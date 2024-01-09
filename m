Return-Path: <linux-kernel+bounces-21417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D6828EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E5D2885AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F03DB88;
	Tue,  9 Jan 2024 21:28:15 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6E20E7;
	Tue,  9 Jan 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so1477102a12.3;
        Tue, 09 Jan 2024 13:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704835693; x=1705440493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbavVFjwhN0dnJZu5HK083iY1XpuyuJB8VgQF8fYrDA=;
        b=lojP7SbbPsX5kOlcEyQqHxKq+E/8odbkzTaMWdDPa9jWRyuK388perSo4A3x/x3e1F
         eHkFrOhNr7ga6cDBPp1zfks+kH8eO7fy05atT7o3mpU2xRCY/AsJbHuuoag6lVS0WPkc
         +Qk0m0S8iPdNlzGWz5OIuXBBYiWz0mOwvYWAKZD4hjtyA6eKi4D1RGryCG987p/DyLCw
         PoYq7PqwpaNShDiw5mM2/hbUIRPVLNtCKYFcFa9rcu9m7kMAjIh6M3/b7IlsS0UFn2U6
         RgJfWe8HGInNPFopjlztdgjswBNvtBPy27w9RawwfDbRUWDGQ4hLwS4N3N9j/OBcZ4w1
         ymQg==
X-Gm-Message-State: AOJu0Yw+rhTwK5ZB3rujzRz3ZS0NcobhHtFUNER3rJtKNO7w7PQmNE6C
	WLBdpGmwmrYCFY9qYPiA8Z9Rq81vH+WJVdIdGyQ=
X-Google-Smtp-Source: AGHT+IGhVn/3dB5sZI7ukT+V1aP/EnTK/ecM2V5y8xbuVa58Xk4Zevt1I7ANK4M4yrQAGo9Of4Ids8xbM/M+YphOUxY=
X-Received: by 2002:a05:6300:808a:b0:199:ffab:9796 with SMTP id
 ap10-20020a056300808a00b00199ffab9796mr1083376pzc.124.1704835692569; Tue, 09
 Jan 2024 13:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216072830.1009339-1-namhyung@kernel.org> <ae648bc4-b32c-4b15-8dfc-9dbd481bb927@linux.intel.com>
In-Reply-To: <ae648bc4-b32c-4b15-8dfc-9dbd481bb927@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Jan 2024 13:28:00 -0800
Message-ID: <CAM9d7cgVHHAA0ZHaTYNx9Lmw0+hJJu_EfQRnX8K3AtLCVMznOw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Fix out of range data
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, stable@vger.kernel.org, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 16, 2023 at 4:42=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-12-16 2:28 a.m., Namhyung Kim wrote:
> > On x86 each cpu_hw_events maintains a table for counter assignment but
> > it missed to update one for the deleted event in x86_pmu_del().  This
> > can make perf_clear_dirty_counters() reset used counter if it's called
> > before event scheduling or enabling.  Then it would return out of range
> > data which doesn't make sense.
> >
> > The following code can reproduce the problem.
> >
> >   $ cat repro.c
> >   #include <pthread.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <unistd.h>
> >   #include <linux/perf_event.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/mman.h>
> >   #include <sys/syscall.h>
> >
> >   struct perf_event_attr attr =3D {
> >       .type =3D PERF_TYPE_HARDWARE,
> >       .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >       .disabled =3D 1,
> >   };
> >
> >   void *worker(void *arg)
> >   {
> >       int cpu =3D (long)arg;
> >       int fd1 =3D syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
> >       int fd2 =3D syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0);
> >       void *p;
> >
> >       do {
> >               ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
> >               p =3D mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
> >               ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
> >
> >               ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
> >               munmap(p, 4096);
> >               ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
> >       } while (1);
> >
> >       return NULL;
> >   }
> >
> >   int main(void)
> >   {
> >       int i;
> >       int n =3D sysconf(_SC_NPROCESSORS_ONLN);
> >       pthread_t *th =3D calloc(n, sizeof(*th));
> >
> >       for (i =3D 0; i < n; i++)
> >               pthread_create(&th[i], NULL, worker, (void *)(long)i);
> >       for (i =3D 0; i < n; i++)
> >               pthread_join(th[i], NULL);
> >
> >       free(th);
> >       return 0;
> >   }
> >
> > And you can see the out of range data using perf stat like this.
> > Probably it'd be easier to see on a large machine.
> >
> >   $ gcc -o repro repro.c -pthread
> >   $ ./repro &
> >   $ sudo perf stat -A -I 1000 2>&1 | awk '{ if (length($3) > 15) print =
}'
> >        1.001028462 CPU6   196,719,295,683,763      cycles              =
             # 194290.996 GHz                       (71.54%)
> >        1.001028462 CPU3   396,077,485,787,730      branch-misses       =
             # 15804359784.80% of all branches      (71.07%)
> >        1.001028462 CPU17  197,608,350,727,877      branch-misses       =
             # 14594186554.56% of all branches      (71.22%)
> >        2.020064073 CPU4   198,372,472,612,140      cycles              =
             # 194681.113 GHz                       (70.95%)
> >        2.020064073 CPU6   199,419,277,896,696      cycles              =
             # 195720.007 GHz                       (70.57%)
> >        2.020064073 CPU20  198,147,174,025,639      cycles              =
             # 194474.654 GHz                       (71.03%)
> >        2.020064073 CPU20  198,421,240,580,145      stalled-cycles-front=
end          #  100.14% frontend cycles idle        (70.93%)
> >        3.037443155 CPU4   197,382,689,923,416      cycles              =
             # 194043.065 GHz                       (71.30%)
> >        3.037443155 CPU20  196,324,797,879,414      cycles              =
             # 193003.773 GHz                       (71.69%)
> >        3.037443155 CPU5   197,679,956,608,205      stalled-cycles-backe=
nd           # 1315606428.66% backend cycles idle   (71.19%)
> >        3.037443155 CPU5   198,571,860,474,851      instructions        =
             # 13215422.58  insn per cycle
> >
> > It should move the contents in the cpuc->assign as well.
>
> Yes, the patch looks good to me.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks for your review, Kan.

Ingo, Peter, can you please pick this up?

Thanks,
Namhyung

