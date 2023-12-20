Return-Path: <linux-kernel+bounces-7326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7A81A5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7339A1C21DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAA46558;
	Wed, 20 Dec 2023 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQT6FUgr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4846535
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703091509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNDu1HZ0C5K95nYnPWNhnZ40i0wV618hzUzbkST+wR0=;
	b=OQT6FUgrZudyNXUOTqNR8Y4SpuWXPLkD5whE2Of3n+2qkY8RLFQVSxGHuGMX/+TrHoS71y
	3q5mx7QhYLHwig/ei7//oderZxtZRPTTKoH8HCl/IVBQSxBzlbkvLW7KsOOZ9rOZy/ooX5
	jSL05f2rrL0ydzOPfitYaBGjMqJXfxI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-dimPQcN9PFWfV9Ef0CvFfA-1; Wed,
 20 Dec 2023 11:58:27 -0500
X-MC-Unique: dimPQcN9PFWfV9Ef0CvFfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7C723830081;
	Wed, 20 Dec 2023 16:58:26 +0000 (UTC)
Received: from [10.22.33.206] (unknown [10.22.33.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC983C25;
	Wed, 20 Dec 2023 16:58:25 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------HOEt6Yi0lI9X3MFkCNHIt5Rf"
Message-ID: <ef3e34be-a30a-402b-a806-aa6ef29b410d@redhat.com>
Date: Wed, 20 Dec 2023 11:58:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Content-Language: en-US
To: Zeng Heng <zengheng4@huawei.com>, boqun.feng@gmail.com,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org, guohui@uniontech.com
Cc: linux-kernel@vger.kernel.org, xiexiuqi@huawei.com, liwei391@huawei.com
References: <20231220070204.2662730-1-zengheng4@huawei.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231220070204.2662730-1-zengheng4@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

This is a multi-part message in MIME format.
--------------HOEt6Yi0lI9X3MFkCNHIt5Rf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/20/23 02:02, Zeng Heng wrote:
> Using the UnixBench test suite, we clearly find that osq_lock() cause
> extremely high overheads with perf tool in the File Copy items:
>
> Overhead  Shared Object            Symbol
>    94.25%  [kernel]                 [k] osq_lock
>     0.74%  [kernel]                 [k] rwsem_spin_on_owner
>     0.32%  [kernel]                 [k] filemap_get_read_batch
>
> In response to this, we conducted an analysis and made some gains:
>
> In the prologue of osq_lock(), it set `cpu` member of percpu struct
> optimistic_spin_node with the local cpu id, after that the value of the
> percpu struct would never change in fact. Based on that, we can regard
> the `cpu` member as a constant variable.
>
> In the meanwhile, other members of the percpu struct like next, prev and
> locked are frequently modified by osq_lock() and osq_unlock() which are
> called by rwsem, mutex and so on. However, that would invalidate the cache
> of the cpu member on other CPUs.
>
> Therefore, we can place padding here and split them into different cache
> lines to avoid cache misses when the next CPU is spinning to check other
> node's cpu member by vcpu_is_preempted().
>
> Here provide the UnixBench full-core test result based on v6.6 as below:
> Machine Intel(R) Xeon(R) Gold 6248 CPU, 40 cores, 80 threads
> Run the command of "./Run -c 80 -i 3" over 20 times and take the average.
>
> System Benchmarks Index Values           Without Patch   With Patch     Diff
> Dhrystone 2 using register variables         185518.38    185329.56   -0.10%
> Double-Precision Whetstone                    79330.46     79268.22   -0.08%
> Execl Throughput                               9725.14     10390.18    6.84%
> File Copy 1024 bufsize 2000 maxblocks          1658.42      2035.55   22.74%
> File Copy 256 bufsize 500 maxblocks            1086.54      1316.96   21.21%
> File Copy 4096 bufsize 8000 maxblocks          3610.42      4152.79   15.02%
> Pipe Throughput                               69325.18     69913.85    0.85%
> Pipe-based Context Switching                  14026.32     14703.07    4.82%
> Process Creation                               8329.94      8355.31    0.30%
> Shell Scripts (1 concurrent)                  38942.41     41518.39    6.61%
> Shell Scripts (8 concurrent)                  37762.35     40224.49    6.52%
> System Call Overhead                           4064.44      4004.45   -1.48%
>                                                                      ========
> System Benchmarks Index Score                 13634.17     14560.71    6.80%
>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   include/linux/osq_lock.h  | 6 +++++-
>   kernel/locking/osq_lock.c | 8 +++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index 5581dbd3bd34..f33f47ec0c90 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -9,7 +9,11 @@
>   struct optimistic_spin_node {
>   	struct optimistic_spin_node *next, *prev;
>   	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> +	/*
> +	 * Stores an encoded CPU # + 1 value.
> +	 * Only read by other cpus, so split into different cache lines.
> +	 */
> +	int cpu ____cacheline_aligned;
>   };
>   
>   struct optimistic_spin_queue {
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52b92..17618d62343f 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -96,7 +96,13 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   
>   	node->locked = 0;
>   	node->next = NULL;
> -	node->cpu = curr;
> +	/*
> +	 * After this cpu member is initialized for the first time, it
> +	 * would no longer change in fact. That could avoid cache misses
> +	 * when spin and access the cpu member by other CPUs.
> +	 */
> +	if (node->cpu != curr)
> +		node->cpu = curr;
>   
>   	/*
>   	 * We need both ACQUIRE (pairs with corresponding RELEASE in

The contention on prev->cpu is due to the vcpu_is_preempted() call in 
osq_lock(). Could you try the attached patch to see if that helps?

Thanks,
Longman


--------------HOEt6Yi0lI9X3MFkCNHIt5Rf
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-locking-osq_lock-Minimize-spinning-on-prev-cpu.patch"
Content-Disposition: attachment;
 filename*0="0001-locking-osq_lock-Minimize-spinning-on-prev-cpu.patch"
Content-Transfer-Encoding: base64

RnJvbSA0YTk5ZGVhYzdiZDJhNWUwNWUwOGQ5ODZlNTc2MWU5YTE1Nzc1ZWRhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29t
PgpEYXRlOiBXZWQsIDIwIERlYyAyMDIzIDExOjAzOjM0IC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gbG9ja2luZy9vc3FfbG9jazogTWluaW1pemUgc3Bpbm5pbmcgb24gcHJldi0+Y3B1CgpX
aGVuIENPTkZJR19QQVJBVklSVF9TUElOTE9DS1MgaXMgc2V0LCBvc3FfbG9jaygpIHdpbGwg
c3BpbiBvbiBib3RoCm5vZGUtPmxvY2tlZCBhbmQgbm9kZS0+cHJldi0+Y3B1LiBUaGF0IGNh
biBjYXVzZSBjb250ZW50aW9uIHdpdGggYW5vdGhlcgpDUFUgbW9kaWZ5aW5nIG5vZGUtPnBy
ZXYuIFJlZHVjZSB0aGF0IGNvbnRlbnRpb24gYnkgY2FjaGluZyBwcmV2IGFuZApwcmV2LT5j
cHUgYW5kIHVwZGF0aW5nIHRoZSBjYWNoZWQgdmFsdWVzIGlmIG5vZGUtPnByZXYgY2hhbmdl
cy4KClNpZ25lZC1vZmYtYnk6IFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+Ci0t
LQoga2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYyB8IDIwICsrKysrKysrKysrKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9vc3FfbG9jay5jIGIva2VybmVsL2xvY2tpbmcv
b3NxX2xvY2suYwppbmRleCBkNTYxMGFkNTJiOTIuLjkxMjkzNDAxZTNlNiAxMDA2NDQKLS0t
IGEva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYworKysgYi9rZXJuZWwvbG9ja2luZy9vc3Ff
bG9jay5jCkBAIC04NywxMiArODcsMjcgQEAgb3NxX3dhaXRfbmV4dChzdHJ1Y3Qgb3B0aW1p
c3RpY19zcGluX3F1ZXVlICpsb2NrLAogCXJldHVybiBuZXh0OwogfQogCisjaWZuZGVmIHZj
cHVfaXNfcHJlZW1wdGVkCisjZGVmaW5lIHByZXZfdmNwdV9pc19wcmVlbXB0ZWQobiwgcCwg
YykJZmFsc2UKKyNlbHNlCitzdGF0aWMgaW5saW5lIGJvb2wgcHJldl92Y3B1X2lzX3ByZWVt
cHRlZChzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX25vZGUgKm5vZGUsCisJCQkJCSAgc3RydWN0
IG9wdGltaXN0aWNfc3Bpbl9ub2RlICoqcHByZXYsCisJCQkJCSAgaW50ICpwcHZjcHUpCit7
CisJaWYgKG5vZGUtPnByZXYgIT0gKnBwcmV2KSB7CisJCSpwcHJldiA9IG5vZGUtPnByZXY7
CisJCSpwcHZjcHUgPSBub2RlX2NwdSgqcHByZXYpOworCX0KKwlyZXR1cm4gdmNwdV9pc19w
cmVlbXB0ZWQoKnBwdmNwdSk7Cit9CisjZW5kaWYKKwogYm9vbCBvc3FfbG9jayhzdHJ1Y3Qg
b3B0aW1pc3RpY19zcGluX3F1ZXVlICpsb2NrKQogewogCXN0cnVjdCBvcHRpbWlzdGljX3Nw
aW5fbm9kZSAqbm9kZSA9IHRoaXNfY3B1X3B0cigmb3NxX25vZGUpOwogCXN0cnVjdCBvcHRp
bWlzdGljX3NwaW5fbm9kZSAqcHJldiwgKm5leHQ7CiAJaW50IGN1cnIgPSBlbmNvZGVfY3B1
KHNtcF9wcm9jZXNzb3JfaWQoKSk7Ci0JaW50IG9sZDsKKwlpbnQgb2xkLCBwdmNwdTsKIAog
CW5vZGUtPmxvY2tlZCA9IDA7CiAJbm9kZS0+bmV4dCA9IE5VTEw7CkBAIC0xMTAsNiArMTI1
LDcgQEAgYm9vbCBvc3FfbG9jayhzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX3F1ZXVlICpsb2Nr
KQogCiAJcHJldiA9IGRlY29kZV9jcHUob2xkKTsKIAlub2RlLT5wcmV2ID0gcHJldjsKKwlw
dmNwdSA9IG5vZGVfY3B1KHByZXYpOwogCiAJLyoKIAkgKiBvc3FfbG9jaygpCQkJdW5xdWV1
ZQpAQCAtMTQxLDcgKzE1Nyw3IEBAIGJvb2wgb3NxX2xvY2soc3RydWN0IG9wdGltaXN0aWNf
c3Bpbl9xdWV1ZSAqbG9jaykKIAkgKiBwb2xsaW5nLCBiZSBjYXJlZnVsLgogCSAqLwogCWlm
IChzbXBfY29uZF9sb2FkX3JlbGF4ZWQoJm5vZGUtPmxvY2tlZCwgVkFMIHx8IG5lZWRfcmVz
Y2hlZCgpIHx8Ci0JCQkJICB2Y3B1X2lzX3ByZWVtcHRlZChub2RlX2NwdShub2RlLT5wcmV2
KSkpKQorCQkJCSAgcHJldl92Y3B1X2lzX3ByZWVtcHRlZChub2RlLCAmcHJldiwgJnB2Y3B1
KSkpCiAJCXJldHVybiB0cnVlOwogCiAJLyogdW5xdWV1ZSAqLwotLSAKMi4zOS4zCgo=

--------------HOEt6Yi0lI9X3MFkCNHIt5Rf--


