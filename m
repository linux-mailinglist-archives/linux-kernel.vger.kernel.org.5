Return-Path: <linux-kernel+bounces-122128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDF88F235
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CBB29C1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796F154BEA;
	Wed, 27 Mar 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SQm1gi7F"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C864154C0E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580116; cv=none; b=obJbkgtON9y38kUiSaJpJ+qPAmUkrwxl6K+MnJFglc5iF+/ynvoAfHXtwJ/5V+ksFFU/o6iPwzEM8sMkZ+Qv7V2hUvgQXGwqJdNePS6H5R1M39nY6xsdugsLX/2va+B6wOaMUzguL4YpBg7vQAAfEZTrsx+Q8gTqQdt5wqhytTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580116; c=relaxed/simple;
	bh=yjnC/CBCasvDw2LM0sejAmxx6MYvTSqkkwXuDU8uj6k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oxH5LdLO8D1syE9fyoSO/cBotdjausiuK8zIL6EcGXzq6O0T/lKagryab0LlFaD0FqifwVbFeSLQ5z48CGwIF3mQdVdXBmiXs6e1HHb35hm01eoXE1dRdGnNfgKQRKPiCBox6OCh6oyWhm7et+ZtXnqv8+/u5SC/cgLyRyAmJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SQm1gi7F; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711580110; bh=jk1yV46lAm+yi6INMsUypHSRCc3hOVCSQMQSJ3pK8I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQm1gi7FVr0JDEU3oNQtSu3U0g3KcfpAdqCY2s/aML6RsRuXtxnJzWHfAiMgeL7XO
	 TjjJT5T8FgmU9V/Edi7ug+nX7zDf+V8Ql9YrXF8EHOw61afEAjxRI/GlljuJgFnvcX
	 b7iYrq1OeDaowB3eRVl8UK71HIGOLBop8l6cIkaM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id DC809226; Thu, 28 Mar 2024 06:55:08 +0800
X-QQ-mid: xmsmtpt1711580108tdy6irdzp
Message-ID: <tencent_171E741F760F671C3CCD379896E236784A09@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxyC+pTlSW8/tJKFNoBhQ940TS3SjxPH8KyrgQJvJIKk2xqPO9hu
	 BK/CqSBJdtdmHW5C21RK+uFS/zCr6PlaVrRuj0d95k9WjWRqoDYxBv9lT+10IaYkUc2YPPPUkfUF
	 wAhCFRgd7pSeUkQghNChfx+i3XWP8jx97SyujysHkxJ/z5MAGcqCKszFydQes5isauFKkBIy9UZz
	 sz9SYy88Sn2NXnzF9BqQsrWPgm0hWXuNHYyo9HZvZzjG0Zd4WaF6qkJbotO7tUaMsgv+ZhVBbmTK
	 6dGIIKfvETe4Lc4cgAGmOsr6x808//vPiLzKy1Pkm1dtb4/sWZr237KEnX88l3DpxhIvZ8TwWR9y
	 Fl7DDTBva1TY2ji5toVIYCjkw/FHEblv3I0sICOFAURHNFdyxkEohH4Tg0Q07ah79KomLP9L0DkH
	 REWXVVbzVUsWOKwwBqHky+J60uGu0/GY6E9I4sgb6UinV/H0uSlMeZSLYu04I6USYgO2E5BIk7xk
	 6DvHtjHKUeuGgj0NSiI5AW4xh4mB7D9UykMMMIYJrnGGEUBSIRt9MqdsPaKrfIQkjhWy5Y4BuIPr
	 qcdh0HeTyvfVJxkBR5dB+jiX8NqL94A3q1m2yTeRT9moYPpSPr0az+J4tPI8LTAJEIIFSIGajmd2
	 akIJW4Dk/pdoSsDGnuOw0m7F/qtOp2srIZ048epuEP4ySmUfeeOLuqCu5xRonr7sNkjyI/KWHVSc
	 GoaWSzOgMLyodnHmXbqZJKdqKzY+41FRlg5uqucEi7b6mhdpR/7sH+1zOnGS2KeKEYfhEY1y5egB
	 yr6ilck47iBCZcX/TLi2mN6dbmH6rDq2rB/B0WHYHqeQd0iMtFV1WVy/3MmezS3H9zOn2Ry4Hdul
	 /YTH+GCHEnn2/vFmX9oUIYE9R8QgFzTy9HpdT3cyip8FbvVd/uqNI=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
Date: Thu, 28 Mar 2024 06:55:08 +0800
X-OQ-MSGID: <20240327225507.3311829-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
References: <00000000000069ee1a06149ff00c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in dev_map_enqueue

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 66a27abac311

diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..721b85aebf58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4381,6 +4381,10 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			err = dev_map_enqueue_multi(xdpf, dev, map,
 						    ri->flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
+			if (unlikely(!fwd)) {
+				err = -EINVAL;
+				break;
+			}
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
 		break;


