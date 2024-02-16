Return-Path: <linux-kernel+bounces-69296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60378586B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37031C21B68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EE1419BF;
	Fri, 16 Feb 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOzfxLMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40E135A52;
	Fri, 16 Feb 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115226; cv=none; b=JJidLRhl1XSyFegFlKrmzaX1XwSZWir4BsWTS0isnJYBwci2VYB6oLPeOtDzeS4LDaUVPbOgfYmj7Tmsxxq95/q3vdCh/W7le74IGk74LRrF0cMr38D6WfFdAOmb0ErsPEpbjZ3L5BgfSSD6MqbsenvcTiyNLP/k09yuQAChLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115226; c=relaxed/simple;
	bh=Bfl/Ng5CZItia0/GY+Hx1jAddMyPxQ6niSHRMQS6iz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJfqRSjw8j41KEPVczDGfSvKdeNhLWJfOb3VO1r0tBG9DDtUvi45vUQzheS3X2GYyrhbtD15ajvwwiWk4FRKBUuqwPYPDxtEnmWO/DBuk9KWA7KcJ6zKeST25AoDpsFjlHVaQ42A7XD736T5NtShiLdEX5QEF+QzjPBOE3pMpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOzfxLMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDEFC433C7;
	Fri, 16 Feb 2024 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115225;
	bh=Bfl/Ng5CZItia0/GY+Hx1jAddMyPxQ6niSHRMQS6iz0=;
	h=From:To:Cc:Subject:Date:From;
	b=MOzfxLMOHu6xQfc/ML3X8y0+mGW7q8Q4Y9CCiNbvf3OUYx1qXuEYbM8Yac6LN8z1j
	 DnWiQMctxaeXmQW3sxZbQTB/kNQf6OhnPjKSpKkOnKKYrUsz0nH6Ug6EvKnevq+rHl
	 3P6E4GRWLJGMW4YOmk6f+W75rTJQGEQairmG2BzUBXSLh7mfd7wr9KqrZF8XWbiFPR
	 1omDWeCFRAomQBikiR9bvqeklK6VCDC2DWsZcHNMSNJKByGLYbsU5vacxOcZSEEpai
	 eoRpBsDp4VNBNzspq8JLg4Xg9K5TLq/yf77TBxh74Cen8LqlQVZBHJK/IOTjrxSMJ6
	 lQufX7ox0HfQQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string false-positive
Date: Fri, 16 Feb 2024 21:26:40 +0100
Message-Id: <20240216202657.2493685-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-19 recently got branched from clang-18 and is not yet released.
The current version introduces exactly one new warning that I came
across in randconfig testing, in the copy_to_user_tmpl() function:

include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
  420 |                         __write_overflow_field(p_size_field, size);

I have not yet produced a minimized test case for it, but I have a
local workaround, which avoids the memset() here by replacing it with
an initializer.

The memset is required to avoid leaking stack data to user space
and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
copy_to_user_tmpl()"). Simply changing the initializer to set all fields
still risks leaking data in the padding between them, which the compiler
is free to do here. To work around that problem, explicit padding fields
have to get added as well.

My first idea was that just adding the padding would avoid the warning
as well, as the padding tends to confused the fortified string helpers,
but it turns out that both changes are required here.

Since this is a false positive, a better fix would likely be to
fix the compiler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/xfrm.h | 3 +++
 net/xfrm/xfrm_user.c      | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..99adac4fa648 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -27,6 +27,7 @@ struct xfrm_id {
 	xfrm_address_t	daddr;
 	__be32		spi;
 	__u8		proto;
+	__u8		__pad[3];
 };
 
 struct xfrm_sec_ctx {
@@ -242,11 +243,13 @@ struct xfrm_user_sec_ctx {
 struct xfrm_user_tmpl {
 	struct xfrm_id		id;
 	__u16			family;
+	__u16			__pad1;
 	xfrm_address_t		saddr;
 	__u32			reqid;
 	__u8			mode;
 	__u8			share;
 	__u8			optional;
+	__u8			__pad2;
 	__u32			aalgos;
 	__u32			ealgos;
 	__u32			calgos;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a5232dcfea46..e81f977e183c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2011,7 +2011,7 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 {
-	struct xfrm_user_tmpl vec[XFRM_MAX_DEPTH];
+	struct xfrm_user_tmpl vec[XFRM_MAX_DEPTH] = {};
 	int i;
 
 	if (xp->xfrm_nr == 0)
@@ -2021,7 +2021,6 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 		struct xfrm_user_tmpl *up = &vec[i];
 		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
 
-		memset(up, 0, sizeof(*up));
 		memcpy(&up->id, &kp->id, sizeof(up->id));
 		up->family = kp->encap_family;
 		memcpy(&up->saddr, &kp->saddr, sizeof(up->saddr));
-- 
2.39.2


