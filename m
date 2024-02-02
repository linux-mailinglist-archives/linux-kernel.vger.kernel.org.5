Return-Path: <linux-kernel+bounces-50398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79388847878
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042361F2AC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618214D909;
	Fri,  2 Feb 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkreZhq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5013CE9B;
	Fri,  2 Feb 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899273; cv=none; b=eXP4sFZ+ltFcUM4FtlCTrBh2r4IEp0IvFDk/sRGhOpLF56yLTsv71LipaztefRjI02lGNIJQAdAsMUs+sq1w+98PApW85/fw1/4sYsLlbslWoqIOkAWs3mnpXp1aSBNPLsHd0v3GXdCUz4jxbdU2N50F6iO+FjZO3Z7Mmk0ZOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899273; c=relaxed/simple;
	bh=gqHXrMkDHlKxmoYDuWfVtLdvPEZ9IDVXLemBL1p9mvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdTCimNTE5c7v6Pu0E5iE8qOv9JEzfa3TsjLlbde44F7/+AZ+IwUznAnYq7uc3CN2Inip33MDatN8MVh2WujT5LK6Dnu5b+BBoRKYhfnZhWDSFrnAhLCpImL8gT5Ub0z68tgYTC5swSPZEow/9/+PQ1Ym64NUJgxHABF6Eo6ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkreZhq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018A3C433C7;
	Fri,  2 Feb 2024 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899272;
	bh=gqHXrMkDHlKxmoYDuWfVtLdvPEZ9IDVXLemBL1p9mvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkreZhq0U0CjZapbftVpnR51E0G1+XOBcGuaR+UvCNX1Bc4eBwU1XDTs7apCBZx24
	 A3UEtUQadau5Hb7VFmAu5QRDUdTpnwtb/541o4fZ5OdL+TZ98XbC+vY6eZArTZhnpQ
	 eb+U6jPJKD4AVHjujBpOkWkqtWxMwK3KIxNfvdXWxShVzPVU8k4m4ec8MrRMsd4TSG
	 yTvNnIZIQU4tWft1uQDjpHosZTVmJLymR41UyDuF+bAq3MelFSt4wP4zKIRWwPVfSU
	 B+ldC0UGVm9kM1GMl/8PMHJ4yRZ9pf6Ls/TynjfPOzb7a6ZqN8QFtPB1yB9dmJ6qKy
	 O2qH5qLUAFl7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	llvm@lists.linux.dev,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 08/15] smb: Work around Clang __bdos() type confusion
Date: Fri,  2 Feb 2024 13:40:45 -0500
Message-ID: <20240202184057.541411-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 8deb05c84b63b4fdb8549e08942867a68924a5b8 ]

Recent versions of Clang gets confused about the possible size of the
"user" allocation, and CONFIG_FORTIFY_SOURCE ends up emitting a
warning[1]:

repro.c:126:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  126 |                         __write_overflow_field(p_size_field, size);
      |                         ^

for this memset():

        int len;
        __le16 *user;
	...
        len = ses->user_name ? strlen(ses->user_name) : 0;
        user = kmalloc(2 + (len * 2), GFP_KERNEL);
	...
	if (len) {
		...
	} else {
		memset(user, '\0', 2);
	}

While Clang works on this bug[2], switch to using a direct assignment,
which avoids memset() entirely which both simplifies the code and silences
the false positive warning. (Making "len" size_t also silences the
warning, but the direct assignment seems better.)

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1966 [1]
Link: https://github.com/llvm/llvm-project/issues/77813 [2]
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsencrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index d0ac2648c0d6..d3d4cf6321fd 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -444,7 +444,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
 		len = cifs_strtoUTF16(user, ses->user_name, len, nls_cp);
 		UniStrupr(user);
 	} else {
-		memset(user, '\0', 2);
+		*(u16 *)user = 0;
 	}
 
 	rc = crypto_shash_update(ses->server->secmech.hmacmd5,
-- 
2.43.0


