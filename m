Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317A77E17D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKEXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEXLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:11:31 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F7E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1DUwKDSpKCCoujZwgesbEIMz5irhhs12Cnx4Vl0Ca8g=; b=coXLagLq1QpKhXPzWH6ahwOInI
        Mgi0VFLE9Ywd5jyZcXhtq1jsxfuT9PxXiGj/LTeBcT237IHg3i3/Kpm1jbI8gv9er0ADHOz/6VEQw
        9G3wys5aCcaSEpl5fehCbzR2wlqkgoCSI7zhg5axlaHS+Ef2+kgC7n9yKIbWYiXr905w2ApxMav5A
        o+yP+tKpsSBEFh02r/CkMevco5cok3nORB7//t6q+bMQT9rJQ0lTbFcMSjmyjZDpgUDHy3rn2lEEE
        e034t5vvmaTmSvZE0oL7ZA9ZZytAsdnwmVbrWlbtGkPnu3NYdvfdcQKjOuZZ20CoROvNHLHajfzWj
        /JApdFgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qzmH7-00BilM-2T;
        Sun, 05 Nov 2023 23:11:25 +0000
Date:   Sun, 5 Nov 2023 23:11:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: dlm: Remove impossible to hit if statement
Message-ID: <20231105231125.GR1957730@ZenIV>
References: <CAFhcgOWDZ8+KiwmFRYnaBrqSHyeGDX20PgjGHXWK5UikZHPCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhcgOWDZ8+KiwmFRYnaBrqSHyeGDX20PgjGHXWK5UikZHPCmA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 12:21:49PM -1000, Joey Pabalinas wrote:
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> ---
>  fs/dlm/member.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/dlm/member.c b/fs/dlm/member.c
> index be7909ead71b427aa5..bf7085f21a708ab860 100644
> --- a/fs/dlm/member.c
> +++ b/fs/dlm/member.c
> @@ -294,19 +294,14 @@ static void add_ordered_member(struct dlm_ls
> *ls, struct dlm_member *new)
>   memb = list_entry(tmp, struct dlm_member, list);
>   if (new->nodeid < memb->nodeid)
>   break;
>   }
> 
> - if (!memb)
> - list_add_tail(newlist, head);
> - else {
> - /* FIXME: can use list macro here */
> - newlist->prev = tmp->prev;
> - newlist->next = tmp;
> - tmp->prev->next = newlist;
> - tmp->prev = newlist;
> - }
> + newlist->prev = tmp->prev;
> + newlist->next = tmp;
> + tmp->prev->next = newlist;
> + tmp->prev = newlist;
>  }

* whitespace-damaged diff

* lack of any explanations of the reasons why patch is correct...

* ... unsurprisingly so, since it is obviously broken.

Sure, if you hit even a single iteration of that loop, you will
have memb guaranteed to be non-NULL.  Therefore, to complete the
proof you only need to consider what happens if there is not
a single iteration.  Which is to say, what happens if the list
is empty.  Well, either memb is uninitialized, or there is an
intialization somewhere upstream.  Declaration is not far before
that loop, and it is
        struct dlm_member *memb = NULL;
Er...  So for that change to be correct you need to show that
the list (ls->ls_nodes) can not be empty here.  Unfortunately,
it looks like it very much can be empty, seeing that this
is apparently the only place where elements are added to
the list in question.  So on the very first call it will
hit your "impossible to hit" case.  Which leads to...

* the patch had apparently never been tested.

NACKed-by: Al Viro <viro@zeniv.linux.org.uk>
