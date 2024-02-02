Return-Path: <linux-kernel+bounces-50064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96F8473DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E42291184
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300491487F5;
	Fri,  2 Feb 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV62y6n5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260A1487D3;
	Fri,  2 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889515; cv=none; b=GvbzoIncIWT91PazMq+kDr9H5zM8RSzhAZtfm4Cpkz9LXS39CmGnNE3hRLSoOvlhxI1v29nYMacoMh5r+jU/cFeQOAs6BnzukXIeTwFKvu49xa/jwvveAeUZtorbta5eljdbzdwdM5MCZ+fnK6lj+BlxaakmXX36Z0duShAiP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889515; c=relaxed/simple;
	bh=nSRikX5IZ2J1r96VDgq1SrF4bz4pPtNZkcuO4TYY710=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZ4vPbHv0L4mjV2Bzq+gg+exBAiiRDrschWOy8JERZXG8Kl3xRaaZHfgDVv345mVKOiLIM/MMBqEzTSQXsGjf0QkHuOP+4ztIrEIIotsCQxUJteSkWZMy0+k2pBjkcHjr0brfko94167GAavHKZ1vu+AysElgAKA8Ku9KB2Y3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV62y6n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BF9C433C7;
	Fri,  2 Feb 2024 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889514;
	bh=nSRikX5IZ2J1r96VDgq1SrF4bz4pPtNZkcuO4TYY710=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CV62y6n5vEDASX+xf/AutgHxnf/P5YBnpFM/BAEhoZzY3FEbrJHCneBJB/LQZc+hY
	 9BbfRSPPA5ErdoGySq43TYdBMwI7BW2oK0RB1vMQtM2RDTt55azyoEC7tZ/JtPRL6H
	 gUwPDPbYsVQMTGO1t2+WErK5yFqjfAj2Obq2v14kRac8R5Ppi+17MLKhGoC8NfoidV
	 jeFf5D6ZpQzDwdQHDHChMB94zcz2s10npXwQatOonr+YcmHlY6zO6LueOjKwO07YRm
	 4ZTnYT77R+QtRI7Cpn/R5bRcMl8tq8Fej1uTNv/kpmNMa16hkZ5OvlXAmKw6Lx5SU1
	 hHk/xhtTjNQ1g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 04/27] kconfig: remove compat_getline()
Date: Sat,  3 Feb 2024 00:58:02 +0900
Message-Id: <20240202155825.314567-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1a7a8c6fd8ca ("kconfig: allow long lines in config file") added
a self-implemented getline() for better portability.

However, getline() is standardized [1] and already used in other programs
such as scripts/kallsyms.c.

Use getline() provided by libc.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/getdelim.html

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 53 +-------------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index f53dcdd44597..7f0aa39b68c1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -293,63 +293,12 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 	return 0;
 }
 
-#define LINE_GROWTH 16
-static int add_byte(int c, char **lineptr, size_t slen, size_t *n)
-{
-	size_t new_size = slen + 1;
-
-	if (new_size > *n) {
-		new_size += LINE_GROWTH - 1;
-		new_size *= 2;
-		*lineptr = xrealloc(*lineptr, new_size);
-		*n = new_size;
-	}
-
-	(*lineptr)[slen] = c;
-
-	return 0;
-}
-
-static ssize_t compat_getline(char **lineptr, size_t *n, FILE *stream)
-{
-	char *line = *lineptr;
-	size_t slen = 0;
-
-	for (;;) {
-		int c = getc(stream);
-
-		switch (c) {
-		case '\n':
-			if (add_byte(c, &line, slen, n) < 0)
-				goto e_out;
-			slen++;
-			/* fall through */
-		case EOF:
-			if (add_byte('\0', &line, slen, n) < 0)
-				goto e_out;
-			*lineptr = line;
-			if (slen == 0)
-				return -1;
-			return slen;
-		default:
-			if (add_byte(c, &line, slen, n) < 0)
-				goto e_out;
-			slen++;
-		}
-	}
-
-e_out:
-	line[slen-1] = '\0';
-	*lineptr = line;
-	return -1;
-}
-
 /* like getline(), but the newline character is stripped away */
 static ssize_t getline_stripped(char **lineptr, size_t *n, FILE *stream)
 {
 	ssize_t len;
 
-	len = compat_getline(lineptr, n, stream);
+	len = getline(lineptr, n, stream);
 
 	if (len > 0 && (*lineptr)[len - 1] == '\n') {
 		len--;
-- 
2.40.1


