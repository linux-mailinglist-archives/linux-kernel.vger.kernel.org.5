Return-Path: <linux-kernel+bounces-55407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE884BC52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05481F277F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975ED52B;
	Tue,  6 Feb 2024 17:39:40 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F02D517;
	Tue,  6 Feb 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241179; cv=none; b=LP6ZDV1P/XxX98O+wkFQnspEbgfUTWp3EbmAcpmy+FDG+Rks1EWSLXiSldx7xZTNuuDCyoL4FW30C33EnRa0FbioWJH2/2bf53+ls1ZY7AdiPkk/lfRUkGu1UPyXxCmRhsqH15alLvOeBip0+diuoQrqr50oKpiZP5IdboBpGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241179; c=relaxed/simple;
	bh=vRtSngSZ1LHNibkVF1r+Xu2ql+WRcWagH9Pl3kuQI8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AZ6HI1eNPMHx2fGK16brad3jDiR9k+F7yaSu8eYPnWXlM6RuKzCuPgvmRwgwJBKvo7T3LS913MugKcIIImyFA99dFLH0FDXBjRYcGf3uhqzZS+ZnYc4anm72T2LRX3kxbJAC1AhN4UodJAqOPjpg9JHmYoOVz4y6R9PIDzab3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.15])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TTr8v2zLmzfYwQ;
	Tue,  6 Feb 2024 20:39:27 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Kees Cook <keescook@chromium.org>,
	Liang Chen <liangchen.linux@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15/6.1 0/1] net: prevent mss overflow in skb_segment()
Date: Tue,  6 Feb 2024 20:38:43 +0300
Message-Id: <20240206173844.30271-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigvhicurfgrnhhovhcuoegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepudehuefgveehffekleekleetteefvedtveeujeekvdetjedvtdeuueetjedtleeunecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrddujeejrddvtddrudehnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdduheeijedtfedrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvddtrdduheemgeehjeegvddpmhgrihhlfhhrohhmpegrphgrnhhovhesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghprghnohhvsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
 hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhopehmkhhhrghlfhgvlhhlrgesphhurhgvshhtohhrrghgvgdrtghomhdprhgtphhtthhopehpthihrggurghvsegrmhgriihonhdruggvpdhrtghpthhtohepkhgvvghstghoohhksegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehlihgrnhhgtghhvghnrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlohdrlhgvihhtnhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.61.08090, Virus records: 12326436, Updated: 2024-Feb-06 16:36:35 UTC]

Syzkaller reports NULL pointer dereference issue at skb_segment()
in 5.10/5.15/6.1 stable releases. The problem has been fixed by
the following patch which can be cleanly applied to 5.10/5.15/6.1 branches.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.


