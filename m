Return-Path: <linux-kernel+bounces-13451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F48206C7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B8B21063
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD109463;
	Sat, 30 Dec 2023 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JrZgkkLc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F08C17;
	Sat, 30 Dec 2023 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703946312; x=1704551112; i=markus.elfring@web.de;
	bh=dI9cCClD6JexG1woOmdgPnUw06082v8DX+zQoFVxay0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JrZgkkLcSZEPJI2sUZwLyvAFvdiwnzUUMNrTO+464QkuRNRbHs0x0k+4okj/iV3n
	 RleY5H0MRaRdI6RTzbBQHRRvq+7MvBUeqsOSc3NJXUEJfGPYNPcyuRMb2WY6DScgH
	 XZ8+l1Dry/BirwDYtwVnvLrn/cwZ4DPbhnL7YUV/pjpOIJ6EPuUbFu6vBWEHBvPTI
	 FIwl0YQOSBl6WkizinXiUky2nwsom+ojXYDpACegt7/BzGmx5+IcyrJbh33PV29t7
	 FSYRJmASTws7Fljq7ADYjU6fgk8hFPRl/HYKXoZSyvi1aRYiAhzVTKhNQZscmWSGk
	 OKiHxIUdn5h86cX3UA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1r7xFt1Rhd-0159S3; Sat, 30
 Dec 2023 15:25:12 +0100
Message-ID: <38dfe7b6-6d8b-4056-9943-12197c80f4d7@web.de>
Date: Sat, 30 Dec 2023 15:25:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
Content-Language: en-GB
To: James Bottomley <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
 <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
 <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
 <a3825ab2-8987-4b85-9db0-642035789c49@web.de>
 <4018ab9225ecaf18501e54114a94217a58a8a57f.camel@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4018ab9225ecaf18501e54114a94217a58a8a57f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GNJw0eiTnvRz1Z7tZBuB+o4pb2XmsXkWWTZiR+2n3Tvnb6BFqlp
 pAi4/57LDG+7T+iqF45/wO7HVSzok2K91AmYGWbueThOhNsTbMdd/XS1h4jVX+bIJiSfBee
 y+TE/KR2g1a0mx/hHl1Eng1SxE4DnQBlK2d9/1y9QbHRIag5zCKiw3Jf7vcfHBza0ZeL3Ot
 NOU7r/Ul+GWy3MtQJA0Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dv4K7cuIcss=;f9YSP876OXo4u8npqQbrBWqzcnR
 Aa5pg1EAca/6Vvw6iVYzRo07mMqjCV5x3Bx9SCn/KZqfb39Kszo7sk4UtLK8hjOciIl72hIje
 HJirzLhbASjwNDjaY64AzE37v7kGcO/p72Rs3YkY1+6Jswx4s+zg4XjNLLBIt0jQ+NC/6qlwz
 fq5WwDbZY3uaRC/EkUETlx+emjPRzeFrUvi2wRXM/jVF+merCQIpchW4IRHQO7PSRlKfDfFdC
 QGqJVvkHUITnTjaFlT3E8ugMaWh1moO+Zjl3JSe/nHfEXt7GHCUk3IhwIneT/eUbPmaVOzKil
 v7A+X0ArDLhikEGDWBq8IAFf20mV8D7S2T5wlZKX8sOioLL1JW2ZzM8EKkLvgy//X25PoERwX
 eBMQYEOAX/46J938bbBNs/hYkl3WvK8ZGNEB6BGPsm4sZ9EVKOG1dWtYbWMpBHwLNc855f7K1
 VZPx/qXMhXmuzqy9NO2zbcyF8upj0pFsMO2DEjGsvgE8N0nFs46+KfimnfmjA/LwI0l9phEax
 Ras33D5O/u9iJHjtNsK+sEN6yCoy8O645a/T2tkfSe09zyuymbg0cysAZzz8+JOg26yt2RZqe
 3vyRGw0kZeO66qGVTlEbZBR+sInbuXB96+umk4LiuVHYrOvmS1CIIf6JqgYXRm1La+4m+A40q
 yUpB+v7fvphXCWVCutulLBcr+MpPSLztGboAF0sqDMK0gE1lMsXTBmWCQDy1BytrNKXyuFF6s
 WF4FFcn/4aZ40Xi9mOuslFbeUCuKQFm9WLVEIomBlFTWijuBk0acIDudd5ATdfs7+ykUEjlnz
 ZQ9DQcGKgjMFZX79MySJA2zQ4lMED7uUNtzKWTupva5+14t5+nnae61oQU0LJMZtDQlDyXSoD
 2zADWO5ELDdUyeRfCEzvTfGPKReLBwbtNZkQ8Vb+xNkOKSoyoY63VIQyeNGI6AT7QdZkNg2fb
 0kNrI4d/cH5rQd99QHOYQYMY9cM=

>> If you would dare to follow advice from goto chains in a strict way,
>> I imagine that you can tend to stress the attention for more useful
>> data processing a bit more than such a redundant function call.
>
> It's about maintainability and simplicity.  Eliminating kfree(NULL)
> doesn't simplify most code,

I find it easy to avoid such a call in the affected and concrete
function implementation.


>                             it just makes the exit paths more complex

Where is undesirable software complexity here in the repositioning
of the label =E2=80=9Csimple_populate=E2=80=9D before the statement =E2=80=
=9Cbuf =3D NULL;=E2=80=9D?

Regards,
Markus

