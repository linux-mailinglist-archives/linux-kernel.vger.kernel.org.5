Return-Path: <linux-kernel+bounces-42403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C2D8400DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC08D1C22C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82154F8D;
	Mon, 29 Jan 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Teu787rA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4254BFB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519103; cv=none; b=eAzWbCLQfc2PlneTDK+YaM9MFPlrdZE1PKDdJkBiOFeg8Wotk9v9cToqWF+Bgfnr6z7bik5hQDmEZlGIcGBJxtLzzEjEs6NjasrezeJT7PU62YNZyPn0GxXtqB0SpQT7j4lm02oNpcsAj7jGQmEozYqlMtHIZsVUlRizElaEPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519103; c=relaxed/simple;
	bh=VJvkIe/MENx6xqRVqQh2+H9rOcn9rWjIoJplPArrUq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iSR2Tvu1jkcIN4DhS/VzSUOEKV8y/Rmfx6ND//MbID6AgD2cZmoXf25VkwhRUPmjpSiauyBRrNJ8S+cjotnNFnl+FmL/pfNpOTWixRl9tzd4McSKWB0VIPA8eccBj0WaH0qtqK4PSGbq3E+wqZGtcHgnW9Tll09Tx2Njnx180ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Teu787rA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706519095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GPGwyui0Z38uDt+2tS5AdYhBJQdQKP0ZtYseGgohscg=;
	b=Teu787rAQOv4m4QkHGJOu1bS5eVkNDa4Pl9rjVa1Xa5k2RETkltKmsjJy81qi7dUQ/TR+a
	xVHkFsRZetOmqVKQuxE5GPXt15rZItV4wEaFTXEFHExdPKeOUAb3yOjbgcILLE6/Q+j0dx
	YfkElH8+bE2nHsN+Y5NsMU2KXRCjtuk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-KE7mTPiyPdCZAXieqUZiRw-1; Mon, 29 Jan 2024 04:04:53 -0500
X-MC-Unique: KE7mTPiyPdCZAXieqUZiRw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337cc89a049so1293407f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519092; x=1707123892;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPGwyui0Z38uDt+2tS5AdYhBJQdQKP0ZtYseGgohscg=;
        b=wa9q4cisnykNutc2s6EAB5drmybZ83fRJ0Kskv0X9n8e4cKuK1PlZZKXsST9UipvZZ
         vfVUFXSChwxU/F5Ma23bBd7yXSACwMSL0lAP3IDtPzSrP3BjI4lhcYmx9vhxAqsWsyVK
         6UjosrZbBB7zxyU3ByQRvnvlZIJGmQ2EnnLvp0tidaw+YKVDRLKQTdK/wkGacV+bn892
         rxS2PqAv2tHJFd3nhZw3JtsRbvkaen48HBHqL77TMIyMTrwMyZ2tcwUOnhhi2ErHWCxp
         55a9x12sC+Af6t19xo58ss1nWNd5EpTtjbxGBR/CHgDegwdkliQyNYxQ0Yd19vKab29b
         AlXQ==
X-Gm-Message-State: AOJu0YxJ6ZoPVVrzs9c51RZX3xtIhZJR2l0aE+kzS7bmJL/rUa3rf+M9
	IE3gDOpfSJ4lLEcNaVaUcfcBCUaM8RAQV0V0pQslZu0lSf9mA1u9IOzwX6li9t5jzxdCl5S7Nqv
	mRIT3Ct8VS/J6Dj0k8OKx7s9TYOrIXshoIiTyxUKwavfKbEH8wep71pCPVok0lnN1yI4c5MpVUm
	lnJYgcbJlPm63z7uYopkehZm8wznPvE8DvH2j9TJ3g7wLdFw==
X-Received: by 2002:a05:6000:1a88:b0:33a:ed85:f23f with SMTP id f8-20020a0560001a8800b0033aed85f23fmr1742450wry.15.1706519092049;
        Mon, 29 Jan 2024 01:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErRlb3yWQyKsGEa8fyyMOnt7X/8Z4waSJ3/2+gAeDdD2FrMmHUIP11niiRjhVZZYgv0abJiw==
X-Received: by 2002:a05:6000:1a88:b0:33a:ed85:f23f with SMTP id f8-20020a0560001a8800b0033aed85f23fmr1742420wry.15.1706519091690;
        Mon, 29 Jan 2024 01:04:51 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm601539wrb.109.2024.01.29.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:04:51 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, Jan Richter <jarichte@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Compare wall time from xen shinfo
 against KVM_GET_CLOCK
In-Reply-To: <20240111135901.1785096-1-vkuznets@redhat.com>
References: <20240111135901.1785096-1-vkuznets@redhat.com>
Date: Mon, 29 Jan 2024 10:04:50 +0100
Message-ID: <877cjs8q8d.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> xen_shinfo_test is observed to be flaky failing sporadically with
> "VM time too old". With min_ts/max_ts debug print added:
>
> Wall clock (v 3269818) 1704906491.986255664
> Time info 1: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> Time info 2: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> min_ts: 1704906491.986312153
> max_ts: 1704906506.001006963
> ==== Test Assertion Failure ====
>   x86_64/xen_shinfo_test.c:1003: cmp_timespec(&min_ts, &vm_ts) <= 0
>   pid=32724 tid=32724 errno=4 - Interrupted system call
>      1	0x00000000004030ad: main at xen_shinfo_test.c:1003
>      2	0x00007fca6b23feaf: ?? ??:0
>      3	0x00007fca6b23ff5f: ?? ??:0
>      4	0x0000000000405e04: _start at ??:?
>   VM time too old
>
> The test compares wall clock data from shinfo (which is the output of
> kvm_get_wall_clock_epoch()) against clock_gettime(CLOCK_REALTIME) in the
> host system before the VM is created. In the example above, it compares
>
>  shinfo: 1704906491.986255664 vs min_ts: 1704906491.986312153
>
> and fails as the later is greater than the former.  While this sounds like
> a sane test, it doesn't pass reality check: kvm_get_wall_clock_epoch()
> calculates guest's epoch (realtime when the guest was created) by
> subtracting kvmclock from the current realtime and the calculation happens
> when shinfo is setup. The problem is that kvmclock is a raw clock and
> realtime clock is affected by NTP. This means that if realtime ticks with a
> slightly reduced frequency, "guest's epoch" calculated by
> kvm_get_wall_clock_epoch() will actually tick backwards! This is not a big
> issue from guest's perspective as the guest can't really observe this but
> this epoch can't be compared with a fixed clock_gettime() on the host.
>
> Replace the check with comparing wall clock data from shinfo to
> KVM_GET_CLOCK. The later gives both realtime and kvmclock so guest's epoch
> can be calculated by subtraction. Note, the computed epoch may still differ
> a few nanoseconds from shinfo as different TSC is used and there are
> rounding errors but 100 nanoseconds margin should be enough to cover
> it (famous last words).
>
> Reported-by: Jan Richter <jarichte@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/x86_64/xen_shinfo_test.c    | 36 ++++++++-----------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index 9ec9ab60b63e..5e1ad243d95d 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -375,20 +375,6 @@ static void guest_code(void)
>  	GUEST_SYNC(TEST_DONE);
>  }
>  
> -static int cmp_timespec(struct timespec *a, struct timespec *b)
> -{
> -	if (a->tv_sec > b->tv_sec)
> -		return 1;
> -	else if (a->tv_sec < b->tv_sec)
> -		return -1;
> -	else if (a->tv_nsec > b->tv_nsec)
> -		return 1;
> -	else if (a->tv_nsec < b->tv_nsec)
> -		return -1;
> -	else
> -		return 0;
> -}
> -
>  static struct vcpu_info *vinfo;
>  static struct kvm_vcpu *vcpu;
>  
> @@ -425,7 +411,6 @@ static void *juggle_shinfo_state(void *arg)
>  
>  int main(int argc, char *argv[])
>  {
> -	struct timespec min_ts, max_ts, vm_ts;
>  	struct kvm_xen_hvm_attr evt_reset;
>  	struct kvm_vm *vm;
>  	pthread_t thread;
> @@ -443,8 +428,6 @@ int main(int argc, char *argv[])
>  	bool do_eventfd_tests = !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL);
>  	bool do_evtchn_tests = do_eventfd_tests && !!(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
>  
> -	clock_gettime(CLOCK_REALTIME, &min_ts);
> -
>  	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>  
>  	/* Map a region for the shared_info page */
> @@ -969,7 +952,6 @@ int main(int argc, char *argv[])
>  	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &evt_reset);
>  
>  	alarm(0);
> -	clock_gettime(CLOCK_REALTIME, &max_ts);
>  
>  	/*
>  	 * Just a *really* basic check that things are being put in the
> @@ -978,11 +960,16 @@ int main(int argc, char *argv[])
>  	 */
>  	struct pvclock_wall_clock *wc;
>  	struct pvclock_vcpu_time_info *ti, *ti2;
> +	struct kvm_clock_data kcdata;
> +	long long delta;
>  
>  	wc = addr_gpa2hva(vm, SHINFO_REGION_GPA + 0xc00);
>  	ti = addr_gpa2hva(vm, SHINFO_REGION_GPA + 0x40 + 0x20);
>  	ti2 = addr_gpa2hva(vm, PVTIME_ADDR);
>  
> +	vm_ioctl(vm, KVM_GET_CLOCK, &kcdata);
> +	delta = (wc->sec * NSEC_PER_SEC + wc->nsec) - (kcdata.realtime - kcdata.clock);
> +
>  	if (verbose) {
>  		printf("Wall clock (v %d) %d.%09d\n", wc->version, wc->sec, wc->nsec);
>  		printf("Time info 1: v %u tsc %" PRIu64 " time %" PRIu64 " mul %u shift %u flags %x\n",
> @@ -991,14 +978,19 @@ int main(int argc, char *argv[])
>  		printf("Time info 2: v %u tsc %" PRIu64 " time %" PRIu64 " mul %u shift %u flags %x\n",
>  		       ti2->version, ti2->tsc_timestamp, ti2->system_time, ti2->tsc_to_system_mul,
>  		       ti2->tsc_shift, ti2->flags);
> +		printf("KVM_GET_CLOCK realtime: %lld.%09lld\n", kcdata.realtime / NSEC_PER_SEC,
> +		       kcdata.realtime % NSEC_PER_SEC);
> +		printf("KVM_GET_CLOCK clock: %lld.%09lld\n", kcdata.clock / NSEC_PER_SEC,
> +		       kcdata.clock % NSEC_PER_SEC);
>  	}
>  
> -	vm_ts.tv_sec = wc->sec;
> -	vm_ts.tv_nsec = wc->nsec;
>  	TEST_ASSERT(wc->version && !(wc->version & 1),
>  		    "Bad wallclock version %x", wc->version);
> -	TEST_ASSERT(cmp_timespec(&min_ts, &vm_ts) <= 0, "VM time too old");
> -	TEST_ASSERT(cmp_timespec(&max_ts, &vm_ts) >= 0, "VM time too new");
> +
> +	TEST_ASSERT(llabs(delta) < 100,
> +		    "Guest's epoch from shinfo %d.%09d differs from KVM_GET_CLOCK %lld.%lld",
> +		    wc->sec, wc->nsec, (kcdata.realtime - kcdata.clock) / NSEC_PER_SEC,
> +		    (kcdata.realtime - kcdata.clock) % NSEC_PER_SEC);
>  
>  	TEST_ASSERT(ti->version && !(ti->version & 1),
>  		    "Bad time_info version %x", ti->version);

Ping?

-- 
Vitaly


