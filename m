Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0280FB40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377983AbjLLXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjLLXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4233AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:20:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36CC433C8;
        Tue, 12 Dec 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702423222;
        bh=MmuTxz83cx0n6rxBCcxvgqykYUBl9tgr/pJ/GiWM7m4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=seNusqXb36VT70NM24G3CFxzt/BfIWZGd/uw4bohuVn1NxOGzFvQSjxO/JMYuiqYb
         ydn6LffW/t3l0JT0daqOGkmVfJ8CgXMJwxrleNy8AiUmb03ieMSvnrKTDDOBjb1zp2
         r/+QH7/32OfnnZJ2XsgqA9b6JNJZmOLvr+5sGYCNBOxCsV2Yel5iKuevc7fKX/33f+
         dj5fs8Ll5W+eYO4atEyS1CECRtY4psP+oEuQrjThJYBN2jAZ/5klO90mOCR0aMXl3g
         TqfoyNi91vCdl3YzcfESaeKcbNzs3TFcAsVoWO7ZhohvoIQ5AQTQWES68W6Mnc+U8P
         0zn5jAmYXm9PA==
Date:   Tue, 12 Dec 2023 15:20:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Kunwu Chan <chentao@kylinos.cn>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jacob.e.keller@intel.com>, <przemyslaw.kitszel@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
Message-ID: <20231212152020.4a24b2f7@kernel.org>
In-Reply-To: <6ba1e424-9903-43db-b567-32a864b896c9@intel.com>
References: <20231211025927.233449-1-chentao@kylinos.cn>
        <20231212132851.59054654@kernel.org>
        <6ba1e424-9903-43db-b567-32a864b896c9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 15:05:19 -0800 Jesse Brandeburg wrote:
> On 12/12/2023 1:28 PM, Jakub Kicinski wrote:
> > On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:  
> >> kasprintf() returns a pointer to dynamically allocated memory
> >> which can be NULL upon failure.
> >>
> >> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")  
> > 
> > No need for the allocation here, print to a buffer on the stack.  
> 
> Sure, but I think that just takes us full circle back to where we
> started. reverting this to the previous code will add back W=1 warnings.
> 
> The whole point of the commit mentioned above was to get a reasonable
> implementation that won't cause string truncation warnings. Is there
> some trick I don't know about to get an allocation which will not
> trigger snprintf and friends to print warnings from -Wformat-truncation

Hm, it'd be nice if there was a flavor of snprintf which explicitly
doesn't trigger this warning. Or perhaps a marking for the output
buffer that says "truncation OK".

Absent that, can we print to a buffer on the stack and copy?
The link message is probably meh, but automation may get quite
confused if a NIC suddenly stops reporting FW version..
