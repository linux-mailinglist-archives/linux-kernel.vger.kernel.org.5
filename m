Return-Path: <linux-kernel+bounces-49021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFF8464E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA37A1F22BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694315BE;
	Fri,  2 Feb 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWSSMaSK"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15986C8D2;
	Fri,  2 Feb 2024 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832377; cv=none; b=ZVRXw1xPZZjI6/zj3zqUbXhfJokMhvbyvvTS1KvkbHsajIRjmf6CqlrPoYKqxV2JN7fHlvqhvi2+pqtukt7B7LCTvw6vKy7eZWuyAgVTF0Xxu2vref2+3wKH/2ipKp4GE8sOOsogAPBrl1+tR16wuYdb0gViZKGd0kID6781Ges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832377; c=relaxed/simple;
	bh=N5ytPMI8CcBmVCIRgJRyHCtLc2INmcdE0bUH/E1B1pA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=N5+QxxJ0CKGZxycwK9m0dvouzJXwJ1gWotMOxbRqtz90eE/7mXg7DcUf+1lq8subY/Ia8VEWQOns/cwKrV2qd7ICZKnX5lRr3e5lmvvi97leI88wQfaQjtwT7xb9kAAHMlJ8Us7gYPH2hjnvP1l3Lf4kEjPS3LJLE2jLOmSL8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWSSMaSK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411Nbr7x020563;
	Fri, 2 Feb 2024 00:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=344H4x8Ad8z8mLylBhJTlrMcVRy2QejlkXWVgJvg15c=;
 b=fWSSMaSKXCTh1Gs99inTLNtCPiCtwuibOItyo1C4K4zgA4enOyUXk1rVRITHSzV/kdsL
 vrwMYNUOaUIZBba4PnyY/BGQM05MutP0HoYPHHenVsTbU2VSWc9IuNY3jBvdIcmmaR+7
 EaphozfCgcDiwqdr3XT1HgyYJum8REE5KkHi37ChllKbq7w9eb739DIShztOQpDQbHmR
 qQhQMB6lzrUl+waCRB/Af7Ov+VFhjr0n2b63fqwIvXzM86npCRwa6bIwQuHBM/CiZHP7
 BJtNhd8+QhUy1ZUhur/rvCN/8Cs5hon0E4HTuK5tG2pmatkWWcFkEe7DRAFuIm/6Gth5 aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0n518n4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 00:05:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411NcwFo023109;
	Fri, 2 Feb 2024 00:05:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0n518n3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 00:05:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411MgJYi007189;
	Fri, 2 Feb 2024 00:05:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2qbxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 00:05:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41205qxA48562502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 00:05:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54105805E;
	Fri,  2 Feb 2024 00:05:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2119858059;
	Fri,  2 Feb 2024 00:05:51 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.60.157])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 00:05:51 +0000 (GMT)
Message-ID: <d0ccd2f19ed1adccc8f3dfe677c30bc44feb3d36.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Williams
 <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "dhowells@redhat.com"
 <dhowells@redhat.com>,
        "yaelt@google.com" <yaelt@google.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nichen@iscas.ac.cn"
 <nichen@iscas.ac.cn>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Cc: "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-cxl@vger.kernel.org"
	 <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	 <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "nvdimm@lists.linux.dev"
	 <nvdimm@lists.linux.dev>
Date: Thu, 01 Feb 2024 19:05:50 -0500
In-Reply-To: <CYU2JV57VXA9.3C5QTG4LX50TD@suppilovahvero>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
	 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
	 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
	 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
	 <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
	 <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>
	 <CYS7QMYS8XAJ.2QPI3MS5KXK8E@suppilovahvero>
	 <CYS7WMFLXNE1.35OBTKTONKNX3@suppilovahvero>
	 <65b93f2b3099b_5cc6f29453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <CYU2JV57VXA9.3C5QTG4LX50TD@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oLsn3Vd9Pcs0Fl12p7OhnGd4O-iUA5CF
X-Proofpoint-ORIG-GUID: GJlw1TEeGH8bzKJubicc8sFAJerRWBn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010185

On Thu, 2024-02-01 at 23:43 +0200, Jarkko Sakkinen wrote:
> On Tue Jan 30, 2024 at 8:25 PM EET, Dan Williams wrote:
> > Jarkko Sakkinen wrote:
> > > On Tue Jan 30, 2024 at 7:22 PM EET, Jarkko Sakkinen wrote:
> > > > On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> > > > > On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > > > > > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > > > > > Ah, thanks for confirming! Would you like me to send a
> > > > > > > revert patch or
> > > > > > > will you do it?
> > > > > > 
> > > > > > Revert "KEYS: encrypted: Add check for strsep"
> > > > > >     
> > > > > > This reverts commit
> > > > > > b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > > > > >     
> > > > > > New encrypted keys are created either from kernel-generated 
> > > > > > random
> > > > > > numbers or user-provided decrypted data.  Revert the change
> > > > > > requiring
> > > > > > user-provided decrypted data.
> > > > > > 
> > > > > > 
> > > > > > Can I add your Reported-by?
> > > > > 
> > > > > Yes that works, Thank you.
> > > > 
> > > > This went totally wrong IMHO.
> > > > 
> > > > Priority should be to locate and fix the bug not revert useful
> > > > stuff
> > > > when a bug is found that has limited scope.
> > > 
> > > By guidelines here the commit is also a bug fix and reverting
> > > such commit means seeding a bug to the mainline. Also the klog
> > > message alone is a bug fix here. So also by book it really has
> > > to come back as it was already commit because we cannot
> > > knowingly mount bugs to the mainline, right?
> > 
> > No, the commit broke userspace. The rule is do not cause
> > regressions
> > even if userspace is abusing the ABI in an undesirable way. Even
> > the
> > new pr_info() is a log spamming behavior change, a pr_debug() might
> > be
> > suitable, but otherwise a logic change here needs a clear
> > description
> > about what is broken about the old userspace behavior and why the
> > kernel
> > can not possibly safely handle it.
> 
> The rationale literally gives empirical proof that the log message
> is useful by measure. It would be useless if log level is decreased
> to debug, as then sysadmin's won't take notice. I don't really know
> what is the definition of "spam" here but at least for me actually
> useful log message are not in that category.
> 
> Issue was legit but git revert is objectively an incorrect way to
> address the bug.

No, I made a mistake in upstreaming the patch in the first place.  It
broke the original "encrypted" keys usage.  Reverting it was the
correct solution.

Mimi


