Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F17F91BC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 08:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjKZHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 02:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 02:19:53 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F602101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 23:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sz6pg
        8K8GFP6G+qtpnGDhTkf/u68i8wZ+eAOQw1z30Y=; b=E6NpBQwOV0lra/yPTGN+r
        9hqDtNACo7BqnKPbxpYxXOG4TsdMgDuyZ5cLzsyqjndn3mS3YHPVjX+80Myvw643
        lTuUHE5ret8pGhoadQ19C65Zlwx58qdYAa1JK+8aiPrNA2CX+KBJKsCewi3hY8+h
        IoKufxj1AeNBuZwmG9WjGc=
Received: from localhost.localdomain (unknown [111.35.185.43])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wAXLpde8WJle_b3Dw--.42741S4;
        Sun, 26 Nov 2023 15:19:03 +0800 (CST)
From:   David Wang <00107082@163.com>
To:     liam.howlett@oracle.com
Cc:     akpm@linux-foundation.org, ankitag@nvidia.com,
        bagasdotme@gmail.com, chunn@nvidia.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev, surenb@google.com, willy@infradead.org
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Date:   Sun, 26 Nov 2023 15:18:54 +0800
Message-Id: <20231126071854.19490-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231123143452.erzar3sqhg37hjxz@revolver>
References: <20231123143452.erzar3sqhg37hjxz@revolver>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXLpde8WJle_b3Dw--.42741S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryfurWUWry5KFy3Xw1fWFg_yoW8uF13pw
        43KFnFyF4fJr15Xr1UCw1UtF1UJw4rtw1DJw17Kry0vF4DZFyUJ3W8tF40qry7JryIgr18
        JF4UJw1rXr1kXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-Originating-IP: [111.35.185.43]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBnBE0qlghlnqv7QAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> What this gains us is the ability to remove contention on the mmap lock
> during page faults.  If you were to test contention around that lock,
> you will see a slowdown until you reach v6.4, where per-vma locking
> started to show up.  More benchmarking will show different types of
> fault handling outside of the mmap lock until (I believe) 6.6, where
> most (or all?) types are supported.

I add memory access between mmap and munmap to the simple stress, and timeit.
Following are the numbers measuring total system time for 10,000,000 rounds, it is not very good for 6.7.0-rc2
(The delta column is just "page fault" - "no page fault", roughly the extra time
needed in kernel to deal with page fault, I guess.)

+-----------+------------+---------------+------------------------------------+
|           | page fault | no page fault | delta(kernel time for page fault?) |
+-----------+------------+---------------+------------------------------------+
|   6.0.0   |    64s     |      13s      |                51s                 |
|   6.1.0   |    104s    |      49s      |                55s                 |
| 6.7.0-rc2 |   ~210s    |      67s      |                143s                |
+-----------+------------+---------------+------------------------------------+

Maybe there is something here needed to be tracked.

My test code now is:

	#define MAXN 1024
	struct { void* addr; size_t n; } maps[MAXN];
	void accessit(char *addr, size_t n) {
		for (int i=0; i<n; i+=128) addr[i]=i;
	}
	int main() {
		int i, n, k, r;
		void *p;
		for (i=0; i<MAXN; i++) {
			n = 1024*((rand()%32)+1);
			p = mmap(NULL, n, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
			if (p == MAP_FAILED) {
				perror("fail to mmap");
				return -1;
			}
			maps[i].addr = p; 
			maps[i].n = n;

		}
		for (i=0; i<10000000; i++) {
			k = rand()%MAXN;
	#ifdef PAGE_FAULT
			accessit((char*)maps[k].addr, maps[k].n);
	#endif
			r = munmap(maps[k].addr, maps[k].n);
			if (r) {
				perror("fail to munmap");
				return -1;
			}
			n = 1024*((rand()%32)+1);
			p = mmap(NULL, n, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
			if (p == MAP_FAILED) {
				perror("fail to mmap");
				return -1;
			}
			maps[k].addr = p; 
			maps[k].n = n;
		}
		for (i=0; i<MAXN; i++) munmap(maps[i].addr, maps[i].n);
		return 0;
	}

Thanks
David Wang

