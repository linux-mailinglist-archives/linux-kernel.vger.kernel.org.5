Return-Path: <linux-kernel+bounces-83676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832C869D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FDEB249C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B94D5B0;
	Tue, 27 Feb 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTwtwwnO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC91EB40;
	Tue, 27 Feb 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053706; cv=none; b=mRwxZ6dj6xO1osudWMIkmMTGomsc7EDr69e5iF6n6kemLgNwvzErKnF6tqk/36zX75GvdO9H38q4AYfhV6kJzSWBxK0naS6MvDlXQ6WsJqc0EVQbOAgHJnSA1aSWajxocjr97PyEYSg2vjRVCyrSVSPF4e7RxJv2+2WrY0ya4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053706; c=relaxed/simple;
	bh=aWGMtXKjZtwKFkHdCKcMC3dDCL/jdXyCzvwHLRky/UQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOz8vmeFLCXRCmZKKnLajGQPRhwfkdclxGcZzMC+quGdClS8sJq53x+TyP0PYP8GjxSj0kEatbLmb/+qwF45ibQvwtAfXMSbUXkVXURFrVbr+XPsxZNxi8rIVwiDDEE9+eOzmflYuQUSnpufbc5BCKRAeYP/4wOveYjGZk+rne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTwtwwnO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51313743f1bso178152e87.0;
        Tue, 27 Feb 2024 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709053703; x=1709658503; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2eHhIuQxKd6fFjJgqU3UrUQXAZO+5gYXyI94ZAlJ39g=;
        b=UTwtwwnOkfwKFStYIMXicL+nuCyUX1V1n36tkgk0QGoivZXFF0OQ1OwlDyePpDtkUr
         RnV9z8rZUBHjW7AyKpwLb7c8EIeOZUjrvQxl6Jb+c/8nvtwU7sVsYnIfOBIbem87gfKw
         icl2TLKzemQ7baMwclJzwYbPnIBEG6WyILm7hlfi8ofLh0R/4ZyY+YOkff6NthUZHFSN
         s1C046ICPulLIhqtzamNUck++oLtgJzkZXYxo8ZutCHdofHSCEBFWvTg//0wDTWcGPth
         DelHcUe+0oI7ewQZZqWh+GplkRWm9BSfKsnmKufH1hELTL2gk4dBAZLxQOeR3ra1Jdb8
         zkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053703; x=1709658503;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eHhIuQxKd6fFjJgqU3UrUQXAZO+5gYXyI94ZAlJ39g=;
        b=h0ZgSIyb0dFDCAYBzkKfoQRknz+uVVs0UddNjQ5q1VZJ+4o2zGXtZL3G/S1fr7ten8
         AMGICsyuSqK/TNSNTmjIPCnQDkTz69d6tXm08fyK0pvcHhnmWK/97oCYpxFAVSciz3UZ
         yBcvlEm858nSBV2Ok0pQ+maQf7TS+yPV9BYpk0jVpJBschmQSc2wvqKoV2s4kYQfzi8s
         wxeaI2aDv0edoWvEDmJp7iLAkiEYiw8sddnAKKvGJo5jCz8jLtkRPC7jY0ZkDZnl5QbK
         XaBA0SynqTVmUmgQLXBGLup5/CxwJizeL1MCilEIcrmdoONDoEOTdWCv2xH1YSpoZdeI
         dfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVDcjIZhyG8iqUMxX63Z0BNh9Z3tVP5iBwj0o8MVSv6qbuSNCLesYzDOXF/NbRhx5oo9rIOW+p0esA1WdqeJKvzdJw2nuqGIyfHX/oKsPDvRabuljl2ItsGromJ7xfKk/BWGiwO/+/fOzhHGmKGaBNf8XataFgAfwG+MkYHD+77
X-Gm-Message-State: AOJu0YxaqZIYQxbsnB7aaSYyhDyLrsgZS0ADtgRGKzLbLIKXvIUhAVHR
	LE5TFVfB3kuRGE85+z7heJ87m3tQ/QosFlcqzaH1qJdZesivumdw
X-Google-Smtp-Source: AGHT+IEKQU1aLRfOa9qfh3XPT4qarZeVDJKey/Tu+NM3yTt48huDkk9RrvJgzm5IxDb1k8HTtuaBSQ==
X-Received: by 2002:a05:6512:1089:b0:512:a6cd:b37e with SMTP id j9-20020a056512108900b00512a6cdb37emr6305655lfg.2.1709053702562;
        Tue, 27 Feb 2024 09:08:22 -0800 (PST)
Received: from [192.168.1.96] ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id u3-20020ac25bc3000000b00512dfa19983sm1243438lfn.50.2024.02.27.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:08:21 -0800 (PST)
Message-ID: <098670097a6fd59f3e254c5294882f3fa12e3c65.camel@gmail.com>
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
From: mikhail.v.gavrilov@gmail.com
To: Thomas Gleixner <tglx@linutronix.de>, Mathias Nyman
	 <mathias.nyman@linux.intel.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,  x86@kernel.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 27 Feb 2024 22:08:20 +0500
In-Reply-To: <87r0gz9jxp.ffs@tglx>
References: 
	<CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
	 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
	 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
	 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
	 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
	 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
	 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
	 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
	 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
	 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
	 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
	 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
	 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
	 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
	 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
	 <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
	 <acc2b877-4b42-fd4d-867b-603dae95d09d@linux.intel.com>
	 <87r0gz9jxp.ffs@tglx>
Content-Type: multipart/mixed; boundary="=-pDjTTj6VP5CdDiGZ/5O0"
User-Agent: Evolution 3.51.2 (3.51.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-pDjTTj6VP5CdDiGZ/5O0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-02-26 at 19:09 +0100, Thomas Gleixner wrote:
> we don't have any information about the overall workload,

During measurements nothing was running except iperf3

> other interrupt sources on CPU0 and their frequency. That'd need to
> be investigated with instrumentation and might unearth some
> completely different underlying reason causing this behavior.

I made simple bash script for benchmark enp14s0 on each of CPU core.

#!/usr/bin/env bash
for i in {0..31}
do
	smp_affinity=3D$(echo 'obase=3D16; '$((2 ** i)) | bc)
	echo "echo $smp_affinity > /proc/irq/84/smp_affinity"
	echo $smp_affinity > /proc/irq/84/smp_affinity
	echo 'iperf3 -c primary-ws.local -t 5 -p 5000 -P 1'
	iperf3 -c primary-ws.local -t 5 -p 5000 -P 1
done

And attach here results of iperf3 for kernels 6.7.0 and 6.8.0-rc6.
Which once again makes sure that CPU0 is a bad option in both cases.
And any other CPU does not necessarily 23 allow the network interface
to operate at the limit of the capabilities of the network cable.

I also attach /proc/interrupts I hope this helps clear things up.

I don't know how else to help you. What information to provide.

About repeatability my "unlucky" scenario.
I have two MSI MPG B650I EDGE WIFI motherboards and this problem
happened both at the same time.

It seems the problem has always been there, we just never noticed it.

--=20
Best Regards,
Mike Gavrilov.

--=-pDjTTj6VP5CdDiGZ/5O0
Content-Type: application/zip; name="benchmarking-6.7.0-all-cores.zip"
Content-Disposition: attachment; filename="benchmarking-6.7.0-all-cores.zip"
Content-Transfer-Encoding: base64

UEsDBBQACAAIAF2oW1gAAAAAAAAAAB52AAAgACAAYmVuY2htYXJraW5nLTYuNy4wLWFsbC1jb3Jl
cy50eHRVVA0AB7IH3mWyB95lsgfeZXV4CwABBOgDAAAE6AMAAO2dTW/bRhCG7/oVe29J7zfJS1Ak
uQRFgKLorQgCRaZjobbkkHTSXPrbC1mpzRVnNLtLFR4nVk6BpRdLkc/O546u139dLtdXv/Ttars5
X3Zfiy+9+OeFuN0sr1tRdAtfVqUsfF1erKws/679e29/Om8/3H5cXCOf7W/Pt6K/FOXZ0PZDsby6
Ktbdp7K/XLSry61Q4oU4u+m2q7N19+mstmf99c375cXFerMevi7WN213YUSxEjfd+novWl5tV8sr
UQzCieJGOCmlKH4TavFqu9m0q2G9+SiGrbjc9sPkUz+Lm2033H1m8acQ7p3Yi6lGl8rXpSqVkfv3
GN/UXqz2mu35TvLhXY0PhN68fifebIa2+7y8Eg+vP7rlpr9ou7v/vFwP3XJo7//4ezt0Qrz6sjn/
thIhZClloUophRB9uxKiNmUj3r78OrS9EKKSRrz9sB76s7s/CrF7n7BGiV//e8vudS+3Uyr0WM6X
ciSnVZLcTqkwYzlb1iM5lSa3UypsKKfHF1tBcs4hcjulwo3lXCCnwO9uIleIxH8z7n5438drF1b7
8dodsPb7V99uztupmBqJubGYDsXCV9eu2vXntlvs0ROvt5u23JOquZLqKqvlI5MqlLIPX3LjauCO
OeljSRVKjR7exoByzsaSeijXAHJeNrGkxqwOl5uQKtRu67iX03GrY0Kq82a0dmtnker8+IuwMpNU
y5hUy41UD9kFi5mZLFJtXWeSaiGb6lwuqRYygq6uEkgNLhZ62r063JZ4kjrPpp6I1Jorqab2khup
kF1wFnt4KVJBtLyM9n6FUsHzBLmrXmPgQ6QqEi1UDiI1WB1ooidybEgd33cL7dAUqfLUpCrJGFUO
7u8oxmg8aLbq6ED10M5ATwAuR6HqYPJTjGqAqp7t/hrKRj8V95eFUdVsUXXNLkJ4dFQDqwrZLWd1
AqoBDODTq1NQDciHHihcLg9VVI70f6F9aSrHBlU7F9WTW1XLGtWaGarQLXM6JalEwuCczHWAQSON
ypGhqkySI1EFt7n6UI4NqmTUnoKqPEmoyhdVpRQDVAMHGArfnEmJVUmr6pKySoEc6AArbHVZqOJy
pAMM2vyJHBtU+VlVJTmzaph5wB60NNKctlaDWenMDDAmR7KaFvuSrIJpqu84WD05q5ovq8ZIp3mx
CrrAtsEMIcQqnQnSGA0kq3Dwm5tYgguhqFyWCzyVY8MqvxywZc1qxSAJHLAKOq3qpJmlCi3UQqyO
4yANWS5cDmI12EkgJwKXy8osTeV+AFZVdrjKl9XayMfuLIzJAid0FsYYQtuksEr7wDo7tQRuTKhc
XmppIseG1dn9SidnVUnWsBoGySWyEcLabFjh+Bez0ySsYOorKQ9Mdi7MyAPHybGBlZ9h1Zxh9dpy
s6xgfyGaHCVhhYo2NqkVgpTDc19ZXrDTuf2F8Oombc/PsB6LWDnDWnGDFezenTS0zmoxxOXIZgjY
SU+BlZarUkJWsm/J6UM3gg2s/18qeEbIyhZWV3l2MSsIa5PSDhE8A3B7cUrdhq6xou3FeXWbpH7g
iFzwcz9wNKy7mJUzrew6IkBbmFS5IbPBuFwWrVPjNa95qcL2ksw+Q7aVG34n4jRnWq10mgGtdE8E
ygNpW+HjJ7n5YISHlNrNDDkyaoVN9Q9Yu5lRZ2VNK7fGYKSDKTshDGZwUeuV1Rjs4+dCHJpqsNsQ
lcvrNpzIPdN6NGxlS6vTrmLWb4jEract3/jcJBMMP7o6snwDB5optNJRNd8TN/w84bu4lTGu/I6d
gxVDk+IKk7NXXI0lcUlcQWuYP8oFxDWpPZgs4DBuD+ZnXDVvXN2udM4LV7AMgT7BeUfP0QEsefXW
085zmQ5gicYVPsjzNOqtLLr5LXdcPbPQFe5lynaGYeuqcq0rLOdzQ1ewoR+XyxuUptniys8Zrlnj
aoxR3GJXMDpMmmtIJl/yrSs8iBA1h3k11yTrGuAatzo2uB7raUjF1TVHgoxoXPexK2deNTdewQBM
pXjD9HQXVI6suqbJQbwGR3rSLhbiNZCD8ecavB5FLJnX6shtiuZV8+bVOlk9hfOtDj04Q/IKBnRo
GZfiFXE4U7okAsDg4U6YHJkbjrtYLrwGU1nAQIPiVZ6aV8udV8UuOQweSk2Z8yLH27aCXERcDuA1
lEtbHcBrKAcemUXlKPsaebFceHWG8uVTeA221Vxea968mrrmMO2bTui4lFkvtAWTuV2IyOT7lBnC
werg2lBKzzB5Yn4q933yeizOiOb1W/zKGVjPAFgyTzid2xcNLDxcNwVYOkRMAVaOfkGnkfAPaSQA
G9rruNWxAfaYTUwF1tZHPI1oYDV7YH3DIONEl/zRhh/SI549TzgkLG5i7yyPOKm7KZSDI1iu3U12
HHSqmRkn647c9WhgLXtgK8mgAkunTWRCyikkDO6nTUg5RRCGypHAgv1NqBwEbHCx4O40kWMDrB9/
FTP7m+w4D5L9o3I1c2Ct9Rxi2AgfNhtY0GCbhP5hObIDdQMDm1CDnbM6Elj48ADXGqwdb9TgD2Im
AGuOfa8xwP4LUEsHCBqQ7i92BwAAHnYAAFBLAQIUAxQACAAIAF2oW1gakO4vdgcAAB52AAAgACAA
AAAAAAAAAACkgQAAAABiZW5jaG1hcmtpbmctNi43LjAtYWxsLWNvcmVzLnR4dFVUDQAHsgfeZbIH
3mWyB95ldXgLAAEE6AMAAAToAwAAUEsFBgAAAAABAAEAbgAAAOQHAAAAAA==


--=-pDjTTj6VP5CdDiGZ/5O0
Content-Type: application/zip; name="benchmarking-6.8.0-0.rc6-all-cores.zip"
Content-Disposition: attachment; filename="benchmarking-6.8.0-0.rc6-all-cores.zip"
Content-Transfer-Encoding: base64

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
AAA=


--=-pDjTTj6VP5CdDiGZ/5O0
Content-Type: application/zip; name="proc-interrupts.zip"
Content-Disposition: attachment; filename="proc-interrupts.zip"
Content-Transfer-Encoding: base64

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


--=-pDjTTj6VP5CdDiGZ/5O0--

