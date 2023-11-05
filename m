Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18DA7E1811
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjKEX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEX5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:57:48 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB263C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/hC62UmMLmckVGDgZzDIEnoNTd1G4HUTJSEv/agGOY=; b=PaqyPKDC1lSXJzaz4S+DW1xEuT
        EQrFonvTmByIwYZQdxpBft5a9c3q0quMjvGUuirTXJ3EfX6UUMldQl/tiPL4O3cADFVpzvzFSftk5
        zn/TP7Fm2ZctPVGjiwz+zRoyOlvsBtOdixT0K/CTDLOMftnGHsoq9arZtpsw6lTlc9NUu1kuN8RD9
        1ZWlB0A7RGYe+3XZGQ9qRsAmEXURykSqGPNNX3AX0l9utMbpWhi7L6gyYxyXHTuQvfKKlgGbsxIJf
        pF2DCOwytJFXNcgdu6OJexSkASm1YdoOmg/OyIXPLfbjohW6wDeUHqm2aTeT/YHih7awEDoBiW8Fg
        tARmilIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzmzv-00BjoV-0A;
        Sun, 05 Nov 2023 23:57:43 +0000
Date:   Sun, 5 Nov 2023 23:57:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: dlm: Remove impossible to hit if statement
Message-ID: <20231105235743.GS1957730@ZenIV>
References: <CAFhcgOWDZ8+KiwmFRYnaBrqSHyeGDX20PgjGHXWK5UikZHPCmA@mail.gmail.com>
 <20231105231125.GR1957730@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105231125.GR1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 11:11:25PM +0000, Al Viro wrote:
> Sure, if you hit even a single iteration of that loop, you will
> have memb guaranteed to be non-NULL.  Therefore, to complete the
> proof you only need to consider what happens if there is not
> a single iteration.  Which is to say, what happens if the list
> is empty.  Well, either memb is uninitialized, or there is an
> intialization somewhere upstream.  Declaration is not far before
> that loop, and it is
>         struct dlm_member *memb = NULL;
> Er...  So for that change to be correct you need to show that
> the list (ls->ls_nodes) can not be empty here.  Unfortunately,
> it looks like it very much can be empty, seeing that this
> is apparently the only place where elements are added to
> the list in question.  So on the very first call it will
> hit your "impossible to hit" case.  Which leads to...
> 
> * the patch had apparently never been tested.

Looking at the uses of ->ls_nodes,  I wonder if xarray would be
a better fit here.  Might be interesting to investigate...
