Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33657CBEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJQJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:23:14 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7728E;
        Tue, 17 Oct 2023 02:23:11 -0700 (PDT)
Received: from [192.168.192.84] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 639863F6DB;
        Tue, 17 Oct 2023 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697534590;
        bh=9c9TrpFFr39n7AXXEsBDFsE50iLezhEQNKHyfR6r7yw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=t4iIuE/XQvWpJTYTfjzAU5mXCZJZxWo6GZ1SZjJFPhRoIlw/0KfDqvnZY1BGlCUgj
         7qSA9iHQer2IOsrwRsXL8b802hv11nRBD1QpglRSnGO51FF8IxQDlhuQK6UWEfm18U
         BnqOYdUKdNfomiAxHYrQpVxHlbxfGn9msewX70V4Lv1geAHdpfODkPidjr9fnbPijf
         AWA4Yu4Vf6twdv4MNcKe0TH2tgu+F3y6s/ghtzjhbsgYrZvndnxrRrcGl0DD7DOjuM
         k61in4yXHCLZGmayUV6yMtjvtl+gE6gcjuaZi+X3oWyd8W8q8g3BbG1sZMvrdSyciG
         JBh/vqrYe/H/w==
Message-ID: <94e2be56-b461-403c-b231-71d3dbee7b03@canonical.com>
Date:   Tue, 17 Oct 2023 02:23:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] apparmor: cache buffers on percpu list if there is
 lock, contention
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Anil Altinay <aaltinay@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
 <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
 <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
 <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
 <20231006041837.GA17924@google.com>
 <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

df323337e507 ("apparmor: Use a memory pool instead per-CPU caches")
changed buffer allocation to use a memory pool, however on a heavily
loaded machine there can be lock contention on the global buffers
lock. Add a percpu list to cache buffers on when lock contention is
encountered.

When allocating buffers attempt to use cached buffers first,
before taking the global buffers lock. When freeing buffers
try to put them back to the global list but if contention is
encountered, put the buffer on the percpu list.

The length of time a buffer is held on the percpu list is dynamically
adjusted based on lock contention.  The amount of hold time is
increased and decreased linearly.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
  security/apparmor/lsm.c | 67 ++++++++++++++++++++++++++++++++++++++---
  1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c80c1bd3024a..ce4f3e7a784d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -49,12 +49,19 @@ union aa_buffer {
  	DECLARE_FLEX_ARRAY(char, buffer);
  };
  
+struct aa_local_cache {
+	unsigned int hold;
+	unsigned int count;
+	struct list_head head;
+};
+
  #define RESERVE_COUNT 2
  static int reserve_count = RESERVE_COUNT;
  static int buffer_count;
  
  static LIST_HEAD(aa_global_buffers);
  static DEFINE_SPINLOCK(aa_buffers_lock);
+static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
  
  /*
   * LSM hook functions
@@ -1789,11 +1796,32 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
  char *aa_get_buffer(bool in_atomic)
  {
  	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
  	bool try_again = true;
  	gfp_t flags = (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
  
+	/* use per cpu cached buffers first */
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!list_empty(&cache->head)) {
+		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
+		list_del(&aa_buf->list);
+		cache->hold--;
+		cache->count--;
+		put_cpu_ptr(&aa_local_buffers);
+		return &aa_buf->buffer[0];
+	}
+	put_cpu_ptr(&aa_local_buffers);
+
+	if (!spin_trylock(&aa_buffers_lock)) {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		cache->hold += 1;
+		put_cpu_ptr(&aa_local_buffers);
+		spin_lock(&aa_buffers_lock);
+	} else {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		put_cpu_ptr(&aa_local_buffers);
+	}
  retry:
-	spin_lock(&aa_buffers_lock);
  	if (buffer_count > reserve_count ||
  	    (in_atomic && !list_empty(&aa_global_buffers))) {
  		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
@@ -1819,6 +1847,7 @@ char *aa_get_buffer(bool in_atomic)
  	if (!aa_buf) {
  		if (try_again) {
  			try_again = false;
+			spin_lock(&aa_buffers_lock);
  			goto retry;
  		}
  		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
@@ -1830,15 +1859,34 @@ char *aa_get_buffer(bool in_atomic)
  void aa_put_buffer(char *buf)
  {
  	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
  
  	if (!buf)
  		return;
  	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
  
-	spin_lock(&aa_buffers_lock);
-	list_add(&aa_buf->list, &aa_global_buffers);
-	buffer_count++;
-	spin_unlock(&aa_buffers_lock);
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!cache->hold) {
+		put_cpu_ptr(&aa_local_buffers);
+
+		if (spin_trylock(&aa_buffers_lock)) {
+			/* put back on global list */
+			list_add(&aa_buf->list, &aa_global_buffers);
+			buffer_count++;
+			spin_unlock(&aa_buffers_lock);
+			cache = get_cpu_ptr(&aa_local_buffers);
+			put_cpu_ptr(&aa_local_buffers);
+			return;
+		}
+		/* contention on global list, fallback to percpu */
+		cache = get_cpu_ptr(&aa_local_buffers);
+		cache->hold += 1;
+	}
+
+	/* cache in percpu list */
+	list_add(&aa_buf->list, &cache->head);
+	cache->count++;
+	put_cpu_ptr(&aa_local_buffers);
  }
  
  /*
@@ -1880,6 +1928,15 @@ static int __init alloc_buffers(void)
  	union aa_buffer *aa_buf;
  	int i, num;
  
+	/*
+	 * per cpu set of cached allocated buffers used to help reduce
+	 * lock contention
+	 */
+	for_each_possible_cpu(i) {
+		per_cpu(aa_local_buffers, i).hold = 0;
+		per_cpu(aa_local_buffers, i).count = 0;
+		INIT_LIST_HEAD(&per_cpu(aa_local_buffers, i).head);
+	}
  	/*
  	 * A function may require two buffers at once. Usually the buffers are
  	 * used for a short period of time and are shared. On UP kernel buffers
-- 
2.34.1

