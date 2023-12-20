Return-Path: <linux-kernel+bounces-7064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F281A12A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FC21F22AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D585A3AC3A;
	Wed, 20 Dec 2023 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sg/diu03"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B73AC02
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QCDlE
	bzW5TXyMCl1UgCkBMj1mXpk7iFNAzzxSB/CW7k=; b=Sg/diu03Ax4XfZjm6TMk7
	5OlqjZgDlajl/+R3TSyeRgkfPDV47LhVUbmqu229lig4gFeHFv4n76B5BcCfmbbK
	c9lxpd0jyTrey/QQ9rSjWjzI9ZUWPgW5VK7VFzdDOvsu04LdnNjthwu1QYjqo/qo
	F2u9D970PErHVz+ofWtOdI=
Received: from localhost.localdomain (unknown [120.229.70.191])
	by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3_xQR+4JlSE6KDA--.26908S2;
	Wed, 20 Dec 2023 22:32:51 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: laoar.shao@gmail.com
Cc: bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wudaemon@163.com
Subject: Re: [PATCH v1] sched/rt: Fix rt task's sched latency statistics error in sched_stat_wait trace_point
Date: Wed, 20 Dec 2023 14:32:49 +0000
Message-Id: <20231220143249.833273-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220140112.821992-1-wudaemon@163.com>
References: <20231220140112.821992-1-wudaemon@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_xQR+4JlSE6KDA--.26908S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUn189UUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisA9MbWV4G6E+9AABsy

>>I think we'd better use if (!on_rt_rq(rt_se))
>>
>> +               update_stats_wait_end_rt(rt_rq, rt_se);
>>
hi, Yafang.when execute update_stats_dequeue_rt, rt_se->on_rq is still 0, util dequeue_rt_stack,
the method is not effect.
I this we can use if (p && p != rq->curr) /*Mark the end of the wait period if dequeueing task*/
because schedstats is not supported for rt group,we only need to update rt_se that is realy task.
--
Best regards


