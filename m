Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04A7CB397
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjJPT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjJPT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:58:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0CB0;
        Mon, 16 Oct 2023 12:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660BC433C8;
        Mon, 16 Oct 2023 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697486321;
        bh=QJt2FjmAOk4+5+b+Cj8Y/yCy8j4cnH5smrJ3zqV3En4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FX6MQtvL92gviz8tSxWSfFL5w4oPc6M/5NeJ4RfP2w0ZjzCQNmfkcliOrohxxdXRu
         mGf7jkY+Qp5+gnHnuKwnfGIOb/LYqvb7lLStTNsS5gmREJuEkVMPP5zE9qKJqsXX+h
         fjP+2hFDYTIHs2Fkw5mxJ65yjcMcMJbItI+s02EDjyW8kghqpS03VNdQ5OMrWCydCP
         DmUI2rWd5/7TberVoCzCL9sZYaaHCgCWWyq/OrrxP/rjg3kR5kWZSdhIeH2na82psT
         jkfMsfUdXTGz7eb7AIk0Aj2tV/3myWkuU/HPgTAkuVs5YQVN0or+J4/5Jzjq50e9bI
         O5EYsKIjUxeyw==
Date:   Mon, 16 Oct 2023 21:58:36 +0200
From:   Simon Horman <horms@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hamradio: replace deprecated strncpy with strscpy_pad
Message-ID: <20231016195836.GB1751252@kernel.org>
References: <20231016-strncpy-drivers-net-hamradio-baycom_epp-c-v2-1-39f72a72de30@google.com>
 <202310161242.B0F9B693@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310161242.B0F9B693@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:42:22PM -0700, Kees Cook wrote:
> On Mon, Oct 16, 2023 at 06:42:42PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > We expect both hi.data.modename and hi.data.drivername to be
> > NUL-terminated based on its usage with sprintf:
> > |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> > |               bc->cfg.intclk ? "int" : "ext",
> > |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> > |               bc->cfg.loopback ? ",loopback" : "");
> > 
> > Note that this data is copied out to userspace with:
> > |       if (copy_to_user(data, &hi, sizeof(hi)))
> > ... however, the data was also copied FROM the user here:
> > |       if (copy_from_user(&hi, data, sizeof(hi)))
> > 
> > Considering the above, a suitable replacement is strscpy_pad() as it
> > guarantees NUL-termination on the destination buffer while also
> > NUL-padding (which is good+wanted behavior when copying data to
> > userspace).
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Likewise, thanks. I prefer this over v1.

Reviewed-by: Simon Horman <horms@kernel.org>

