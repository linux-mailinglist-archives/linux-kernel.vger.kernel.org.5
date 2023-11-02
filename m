Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E57DFB4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjKBUOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:14:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59B186;
        Thu,  2 Nov 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x0Ufl3kJR9XTsSlPW8zcy4F+KQbvSb7QulGvGNZDl20=; b=hsnTqt6l5FBhErsMbFP3V4TOwo
        vIBBukr6dGYVafu3aQDwViROBtMTHDhpE3MHnpIJu62yqGAulAxh+601vevOFRWLFG8e0JrNF4oYS
        ofcAQupRAkB9xIkW31UitG/SV6382cNEJa9UFg1T7HaxPuzpv6y7/AKUNP1d74z0urG58dyB4X1Xw
        x4BGZWDY4hNpX2KLeCmdc4i+Tlwxdb+rH2IVkhKI07y8Upwj5GhK4jojqY3EGTddjujaJkXqnV+Gh
        CC+OFPe9c/jbyu5NLCOvuGFR2HoMYuRYpPt/8ldt1/uT4IdaER1ZcF/6evXO+NTz87efPGA5uDh40
        b4HYz/3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qye5A-009wCW-1o;
        Thu, 02 Nov 2023 20:14:24 +0000
Date:   Thu, 2 Nov 2023 20:14:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
Message-ID: <20231102201424.GL1957730@ZenIV>
References: <20231102192134.53301-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102192134.53301-2-pstanner@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> The functions (v)memdup_user() are utilized to copy userspace arrays.
> This is done without overflow checks.
> 
> Use the new wrappers memdup_array_user() and vmemdup_array_user() to
> copy the arrays more safely.

> @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
>  	if (!ct)
>  		return 0;

> -	unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
> +	unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
>  	if (IS_ERR(unilist))
>  		return PTR_ERR(unilist);

a 16bit value times sizeof(something).
  
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 1fe6107b539b..802ceb0a5e4c 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1773,8 +1773,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)

... and here we have
                if (ct >= MAX_DIACR)
			return -EINVAL;

directly upstream, so it's even better - a value below 256 times sizeof(something)

>  		if (ct) {
>  
> -			dia = memdup_user(a->kbdiacr,
> -					sizeof(struct kbdiacr) * ct);
> +			dia = memdup_array_user(a->kbdiacr,
> +						ct, sizeof(struct kbdiacr));
>  			if (IS_ERR(dia))
>  				return PTR_ERR(dia);
>  
> @@ -1811,8 +1811,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
>  			return -EINVAL;

Ditto.

>  		if (ct) {
> -			buf = memdup_user(a->kbdiacruc,
> -					  ct * sizeof(struct kbdiacruc));
> +			buf = memdup_array_user(a->kbdiacruc,
> +						ct, sizeof(struct kbdiacruc));
