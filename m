Return-Path: <linux-kernel+bounces-98968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4458781B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E07C1C20E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400C3FE52;
	Mon, 11 Mar 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7y+2WD6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEC2AEFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167735; cv=none; b=uhdDxXve1YFAQD+SPTAKGFPUCUa1oYNCE5NdY6dUEDhwyEjHl+jxFBAjYvng56IKcdtqCyPYG9Tbd18se61TZ8S3ZS8vJ+FWiQzyq63GCAAegv6v7w3BYtJEv/55UWg8BMtoW4VvExHctVD2vvkK4DjmL8iXPErFQQV2n5NX1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167735; c=relaxed/simple;
	bh=48G19bIYgZNrVznxhTkbxd/Lx5dKYqxQShWXkL7I7Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1tqZYCB3CLeEOV7Cd0liLZJ+jbuk0E47NJChpPiHOzhzySmgcMiirfEUvrtfMJm0xDcDmQgC0GddnkOU1UYkvVyE+ks1wMNuXXaZaCLc4kVdQNjvfhD1rbq7gEjEMp3TdTPOLIiHziRh/eXoznf3nxV+Wyt/tD5WCAKnJM+PS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7y+2WD6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710167733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8Bn0Qza1gC0R7VtqD/37KxM2U8PNSYbow8rmpoOJHE=;
	b=W7y+2WD6/ySaZ7WTjEqVR/fFQRCk5sRmE7qNO7oRpIHFY+jOZUhgAGVPaL9OLwMvgf28R/
	xGmna/7ythTRGIFrBIvxafKYY59jeoiHpLD/E3C7JTFU+TTf9xYWPsiILSaBjYT4ZpS6jS
	6VuSPZZXvH4Rq33+hmyT58tlORt4IQQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-7HzZ2qUVObqKmHxTY4CAxQ-1; Mon, 11 Mar 2024 10:35:31 -0400
X-MC-Unique: 7HzZ2qUVObqKmHxTY4CAxQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690d3f5af86so3311896d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167731; x=1710772531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Bn0Qza1gC0R7VtqD/37KxM2U8PNSYbow8rmpoOJHE=;
        b=ntg0/tgV3aN2mvj1C/PdYNczLKWvZIlqzVNA98sOueX9iRs35SFpSQMbz25h0CdgN8
         3/3Uy1K1oGgT0v4vEF3hGjG6unhUrT19KaWdSOwEe0/hWw3Iuwn9jSfBRuMquKOdd37Q
         lAW9NzSXo8L8BddHUcVRkxxHU/CZq0QS/KMpqCf3+ZsaU8MKRVWeazPUOQuxxrXXubcY
         6CIJ6U6b4bY4xWjH8C3K/UW6saMuJunOARTaAtiCtV6FPjozyON8pGb4MSe02uR3lMy5
         OiT2chJut0vpHdrgsjKyKh7pHlpX2zLBMJCPHEY0kOWX/0VrW0Lezc2BHSASj4IqPMH9
         Txig==
X-Forwarded-Encrypted: i=1; AJvYcCWB3Sf0QHioQ6h04PoW8lPuRv5HeX8OYkpbVf/NkwYeK4cgKS+7Sqhl/9YjQyD/wURFs9jQdR/DyPz5k79PfQwev6feL95sE9Ey1lZ0
X-Gm-Message-State: AOJu0YybPyBc1L2PbMkuOJbzrXJUZ10kBBmDTNS+BczOC5GBjvOrUfFR
	iTUwnoA0ZxilKot+1lPWzpcsgT98wEcfVaaGO9BKHkWamsuSD3d4225WVACSVV7h9kJFAjz8TFz
	O65sgSzuS8XuBAx4d1DkM6N2Z7BWdxa+fpmYBiP+TZaaB0gn0YEOhLs2Kv1pM/Q==
X-Received: by 2002:a05:6214:5817:b0:690:dcc8:6149 with SMTP id mk23-20020a056214581700b00690dcc86149mr878974qvb.4.1710167730554;
        Mon, 11 Mar 2024 07:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDFZwfaCB4HAsZiRTNH9ThEFmAZ+oZRyottgFXIagCv5O/Cci8Kk03bGXgk6z75P4DZjUV5g==
X-Received: by 2002:a05:6214:5817:b0:690:dcc8:6149 with SMTP id mk23-20020a056214581700b00690dcc86149mr878939qvb.4.1710167729947;
        Mon, 11 Mar 2024 07:35:29 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w3-20020a0cf703000000b0068f75622543sm2729017qvn.1.2024.03.11.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:35:29 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:35:27 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: BUG selftests/mm]
Message-ID: <Ze8Wr2qH8V0LMi_5@x1n>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>

On Mon, Mar 11, 2024 at 10:31:41AM +0100, David Hildenbrand wrote:
> On 09.03.24 20:12, Mirsad Todorovac wrote:
> > Hi,
> > 
> > Routine run of the test in net-next gave also this mm unit error.
> > 
> > root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
> > Testing UFFDIO_API (with syscall)... done
> > Testing UFFDIO_API (with /dev/userfaultfd)... done
> > Testing register-ioctls on anon... done
> > Testing register-ioctls on shmem... done
> > Testing register-ioctls on shmem-private... done
> > Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
> > Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing zeropage on anon... done
> > Testing zeropage on shmem... done
> > Testing zeropage on shmem-private... done
> > Testing zeropage on hugetlb... skipped [reason: memory allocation failed]
> > Testing zeropage on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing move on anon... done
> > Testing move-pmd on anon... done
> > Testing move-pmd-split on anon... done
> > Testing wp-fork on anon... done
> > Testing wp-fork on shmem... done
> > Testing wp-fork on shmem-private... done
> > Testing wp-fork on hugetlb... skipped [reason: memory allocation failed]
> > Testing wp-fork on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing wp-fork-with-event on anon... done
> > Testing wp-fork-with-event on shmem... done
> > Testing wp-fork-with-event on shmem-private... done
> > Testing wp-fork-with-event on hugetlb... skipped [reason: memory allocation failed]
> > Testing wp-fork-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing wp-fork-pin on anon... done
> > Testing wp-fork-pin on shmem... done
> > Testing wp-fork-pin on shmem-private... done
> > Testing wp-fork-pin on hugetlb... skipped [reason: memory allocation failed]
> > Testing wp-fork-pin on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing wp-fork-pin-with-event on anon... done
> > Testing wp-fork-pin-with-event on shmem... done
> > Testing wp-fork-pin-with-event on shmem-private... done
> > Testing wp-fork-pin-with-event on hugetlb... skipped [reason: memory allocation failed]
> > Testing wp-fork-pin-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing wp-unpopulated on anon... done
> > Testing minor on shmem... done
> > Testing minor on hugetlb... skipped [reason: memory allocation failed]
> > Testing minor-wp on shmem... done
> > Testing minor-wp on hugetlb... skipped [reason: memory allocation failed]
> > Testing minor-collapse on shmem... done
> > Testing sigbus on anon... done
> > Testing sigbus on shmem... done
> > Testing sigbus on shmem-private... done
> > Testing sigbus on hugetlb... skipped [reason: memory allocation failed]
> > Testing sigbus on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing sigbus-wp on anon... done
> > Testing sigbus-wp on shmem... done
> > Testing sigbus-wp on shmem-private... done
> > Testing sigbus-wp on hugetlb... skipped [reason: memory allocation failed]
> > Testing sigbus-wp on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing events on anon... done
> > Testing events on shmem... done
> > Testing events on shmem-private... done
> > Testing events on hugetlb... skipped [reason: memory allocation failed]
> > Testing events on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing events-wp on anon... done
> > Testing events-wp on shmem... done
> > Testing events-wp on shmem-private... done
> > Testing events-wp on hugetlb... skipped [reason: memory allocation failed]
> > Testing events-wp on hugetlb-private... skipped [reason: memory allocation failed]
> > Testing poison on anon... done
> > Testing poison on shmem... done
> > Testing poison on shmem-private... done
> > Testing poison on hugetlb... skipped [reason: memory allocation failed]
> > Testing poison on hugetlb-private... skipped [reason: memory allocation failed]
> > Userfaults unit tests: pass=42, skip=24, fail=0 (total=66)
> > root@defiant:tools/testing/selftests/mm# grep -i huge /proc/meminfo
> > 
> > It resulted in alarming errors in the syslog:
> > 
> > Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4631e000
> > Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46320000
> > Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46322000
> > Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46324000
> > Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46326000
> > Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46328000
> > Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632a000
> > Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632c000
> > Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632e000
> > Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46330000
> > Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46332000
> > Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46334000
> > Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46336000
> > Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46338000
> > Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633a000
> > Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633c000
> > Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633e000
> > Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46340000
> > 
> > At this point, it can be problem with my box's memory chips, or something with HUGETLB.
> > 
> > However, since the "classic" allocations were successful, the problem might be in huge pages, or
> > if I understood well, in deliberate poisoning of pages?
> > 
> 
> Isn't that just the (expected) side effect of UFFDIO_POISON tests?
> 
> IOW, there is no problem here. We are poisoning virtual memory locations
> (not actual memory) and expect a SIGBUS on next access. While testing that,
> we receive these messages.

Correct.

> 
> The "ugly" thing here seems to be that we can trigger repeated pr_err() from
> user space. There is no rate-limiting in place. Maybe UFFDIO_POISON requires
> root permissions so this cannot be exploited by unprivileged user space to
> flood the system log?
> 
> CCing Axel

This is pretty unfortunate.

I'm not concerned too much on flooding whoever kicks off the selftests, but
indeed this seems to be able to be used by anyone to trigger such endless
reports in dmesg.

The issue with requiring a privilege means any hypervisor that will need to
use this to emulate memory errors will also require such privilege, and it
can be a problem.

Logically such "hwpoison errors" are not real so it is not needed to be
reported in dmesg, but now we're leveraging it to be exactly the same as a
real hw error to share the code path, iiuc (e.g. on MCE injections).

One option is to use a different marker reflecting that such hwpoison error
is internal, so we don't need to report in dmesg. That'll also require
(besides another bit in pte markers) one extra VM_FAULT_* flag just for
such reports.  Might be slightly an overkill, but I don't see another
better way; not reporting HWPOISON will complicate at least kvm use case
even more.

Or.. does syslog has its own protection in general for such printk floods?
It'll be easier if that's not a concern to flood then, but I'm not sure
from that regard.

Thanks,

-- 
Peter Xu


