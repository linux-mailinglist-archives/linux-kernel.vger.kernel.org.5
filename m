Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3B7E91A2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjKLQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:25:10 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 08:25:05 PST
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC2702;
        Sun, 12 Nov 2023 08:25:05 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:25a3:8809:d018:f17])
        by joe.alarsen.net (Postfix) with ESMTPS id 8FD2E180EC7;
        Sun, 12 Nov 2023 17:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1699805792; bh=g29MpB5b2J7H2Cim5OSuRbINZsohURRuZ/RssLR9l/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp705sjF/Kjn9UkwtwOwlRadzzbX2Gj9t7Nmh4DGucpPfhiE/PgNNmOPUXF9F6DXp
         EONsSiYXo8g6nCEqgKnv4ZdJQ4aAeA1z/fpFuQUP+kcBFMhm42XtU9CoOtUYz0HxB5
         ABPr1mHYF00pEnPboUXEK7H+6z1rYTZnbCMYCj4g=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTPS id 7939D2B2;
        Sun, 12 Nov 2023 17:16:32 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Niek Nooijens <nieknooijens@gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Date:   Sun, 12 Nov 2023 17:16:32 +0100
Message-ID: <2655833.BddDVKsqQX@oscar>
In-Reply-To: <20231112095353.579855-1-debug.penguin32@gmail.com>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-12 10:53 Ronald Monthero wrote:
> qnx4 dir name length can vary to be of maximum size
> QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> 'link info' entry is stored and the status byte is set.
> So to avoid buffer overflow check di_fname length
> fetched from (struct qnx4_inode_entry *)
> before use in strlen to avoid buffer overflow.

[snip]

> 
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  fs/qnx4/namei.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..825b891a52b3 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
>  	} else {
>  		namelen = QNX4_SHORT_NAME_MAX;
>  	}
> +
> +	/** qnx4 dir name length can vary, check the di_fname
> +	 * fetched from (struct qnx4_inode_entry *) before use in
> +	 * strlen to avoid panic due to buffer overflow"
> +	 */
> +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> +		return -ENAMETOOLONG;

sizeof(de->di_fname) equals QNX4_SHORT_NAME_MAX, so this test fails as soon as 
a filename is longer than that!

This quick fix (untested!) should do the trick (and avoids computing the length 
of the name twice):

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..7694f86fbb2e 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
+	thislen = strnlen(de->di_fname, namelen);
 	if (len != thislen) {
 		return 0;
 	}

Cheers
Anders


