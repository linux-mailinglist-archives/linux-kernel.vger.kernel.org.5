Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183B5801ADA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjLBFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBFQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:16:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E651116
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 21:16:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FEC433CA;
        Sat,  2 Dec 2023 05:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701494179;
        bh=a5C2kC+KSpawAbx8lhoz4O1Yt38hNED4Gqe/bJLIJXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awNc6pr/csIVFZadi+dsjlFqJH0vMZ2ya0aZlzFChyv3Oe81+rw4R9lfv5pE6X1Wu
         zJDPqLj3FNIO9IyUbrp9totzo/CPWBzfCCb8Jxd7tqbqWcbkcimAEFCaE1bzClx5Mz
         ZmQN3rKeEA4xL5k9EXnOiUohZVbj+iOBVa2GaOzC/Y5QGV29IIXPr8dbfiQcehiCWq
         uaigaHSZhkJ0BrxfRrH4qXSBzLdLSLdxIn00RkSYMhqY+RePTkHFLfTYcV+S9knhEK
         5ZCDev0zcE2qBfG3SoETXSspt3Iy0lIqg82doFYapGl5rokjwF7PtgkttShxOF/xdI
         92qvdxwXfvHDw==
Date:   Fri, 1 Dec 2023 21:16:17 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231201211617.30371d79@kernel.org>
In-Reply-To: <202312012026.A0178237@keescook>
References: <20231130200058.work.520-kees@kernel.org>
        <20231130172520.5a56ae50@kernel.org>
        <202312010953.BEDC06111@keescook>
        <20231201104505.44ec5c89@kernel.org>
        <202312012026.A0178237@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 20:39:44 -0800 Kees Cook wrote:
> > We are reading nla->nla_len, which is the first 2 bytes of the structure.
> > And then we check if the structure is... there?  
> 
> I'm not debating whether it's there or not -- I'm saying the _contents_ of
> "nlattr::nla_len", in the face of corruption or lack of initialization,
> may be less than NLA_HDRLEN. (There's a lot of "but that's can't happen"
> that _does_ happen in the kernel, so I'm extra paranoid.)

nlattr is not an object someone has allocated. It's a header of a TLV
in a byte stream of nested TLVs which comes from user space.
If the attr did not go thru nla_ok() or some other careful validation
we're toast regardless.

> > If we don't trust that struct nlattr which gets passed here is at least
> > NLA_HDRLEN (4B) then why do we think it's safe to read nla_len (the
> > first 2B of it)?  
> 
> Type confusion (usually due to Use-after-Free flaws) means that a memory
> region is valid (i.e. good pointer), but that the contents might have
> gotten changed through other means. (To see examples of this with
> struct msg_msg, see: https://syst3mfailure.io/wall-of-perdition/)

A bit of a long read.

> (On a related note, why does nla_len start at 4 instead of 0? i.e. why
> does it include the size of nlattr? That seems redundant based on the
> same logic you're using here.)

Beats me.
