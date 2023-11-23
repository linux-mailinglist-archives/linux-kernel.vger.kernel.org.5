Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB877F5A02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbjKWIag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:30:33 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51CA1B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Fi8mN
        7QMYiBwweZOW1oXVVDDhUDGPiwsrOjb3qPSKF0=; b=iOMo9PMTicx5T8xFVbipW
        8QYzJVn76Ca03a3rvV58WJTDNOV1J6ETDvrIuVmQdKxgCIbc03mCgVg1d0dglMd5
        ZmVAxUBG6dZnOCDzwpuQCPPZkXkJJu9ipl8xhA0Pmora22e8+e1bhn9nbDoCHAje
        ebNT0ksOxfESUT9zcdBF4Q=
Received: from localhost.localdomain (unknown [111.35.185.43])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wDnD9V1DV9lPSBCAw--.15745S4;
        Thu, 23 Nov 2023 16:29:51 +0800 (CST)
From:   David Wang <00107082@163.com>
To:     bagasdotme@gmail.com
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        ankitag@nvidia.com, chunn@nvidia.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Date:   Thu, 23 Nov 2023 16:29:41 +0800
Message-Id: <20231123082941.21122-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ZV7eHE2Fxb75oRpG@archie.me>
References: <ZV7eHE2Fxb75oRpG@archie.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnD9V1DV9lPSBCAw--.15745S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF45Xw4kXrWfXFW7Cry7GFg_yoW5tF4UpF
        WjqasYkFW0qrnIvFn5Zw4jg3WrZws3Jw13G3s7KanFvF98Zw1aya1xtFWDKry2g3yIgw4x
        Xw4DA3WfXrn8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5xhJUUUUU=
X-Originating-IP: [111.35.185.43]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEB8xql8YMsEAkwAAsz
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

Hi, 

Just contribute some information I recently collected for this thread:

I run some profiler, and it shows fundamental difference between 6.0 and 6.1:


v6.0:
```
__x64_sys_munmap(60.544% 6474/10693)
    __vm_munmap(98.749% 6393/6474)
        __do_munmap(97.982% 6264/6393)
            __split_vma(53.975% 3381/6264)
                vm_area_dup(59.036% 1996/3381)
                __vma_adjust(32.121% 1086/3381)
                anon_vma_clone(5.915% 200/3381)
                vma_dup_policy(0.769% 26/3381)
            unmap_region(16.699% 1046/6264)
            find_vma(10.361% 649/6264)
            remove_vma(7.822% 490/6264)
            percpu_counter_add_batch(2.011% 126/6264)
            __vma_rb_erase(1.405% 88/6264)
            userfaultfd_unmap_prep(0.798% 50/6264)
            downgrade_write(0.511% 32/6264)
```

v6.1:
```
__x64_sys_munmap(68.024% 24741/36371)
    __vm_munmap(99.681% 24662/24741)
        do_mas_munmap(99.015% 24419/24662)
            do_mas_align_munmap(98.243% 23990/24419)
                __split_vma(58.966% 14146/23990)
                    __vma_adjust(83.755% 11848/14146)
                    vm_area_dup(13.191% 1866/14146)
                    anon_vma_clone(2.050% 290/14146)
                    vma_dup_policy(0.254% 36/14146)
                mas_store_prealloc(11.709% 2809/23990)
                mas_preallocate(9.579% 2298/23990)
                unmap_region(5.523% 1325/23990)
```

v6.1 introduce the maple tree data structure, and mmap/munmap performance started to degrade since.
Base on the observation, I tested two commit:
9832fb87834e2bd925d30020962c81b05948fa7b GOOD (Same as v6.0, about 20seonds) (This is before "Patch series "Introducing the Maple Tree")
11f9a21ab65542189372b7d64bb2d2937dfdc9dc BAD  (about 51seconds) (This one is somewhere middle in the path series for maple tree.)
While with v6.1, the test run about 56 seconds

For v6.7, profiler show further fundimental changes, some vmi stuff, and preformance is worse (~70 seconds).
```
__x64_sys_munmap(63.873% 30725/48103)
    __vm_munmap(99.456% 30558/30725)
        do_vmi_munmap(97.670% 29846/30558)
            do_vmi_align_munmap(97.196% 29009/29846)
                __split_vma(63.701% 18479/29009)
                    vma_complete(34.417% 6360/18479)
                    vm_area_dup(33.681% 6224/18479)
                    mas_preallocate(11.835% 2187/18479)
                    down_write(5.173% 956/18479)
                    up_write(3.815% 705/18479)
                    asm_sysvec_apic_timer_interrupt(1.153% 213/18479)
                    anon_vma_clone(0.974% 180/18479)
                    vma_adjust_trans_huge(0.622% 115/18479)
                    mas_next_slot(0.498% 92/18479)
                    vma_dup_policy(0.465% 86/18479)
                    vma_prepare(0.357% 66/18479)
                    srso_return_thunk(0.336% 62/18479)
                    mas_find(0.114% 21/18479)
                unmap_region.constprop.0(12.196% 3538/29009)
                mas_store_gfp(10.548% 3060/29009)
                __call_rcu_common.constprop.0(1.992% 578/29009)
```

I use following test code, and timed it
```
#define MAXN 1024
struct { void* addr; size_t n; } maps[MAXN];
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
```

Thanks
David Wang

