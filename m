Return-Path: <linux-kernel+bounces-37658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897C83B329
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF61C21F63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3013473B;
	Wed, 24 Jan 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F9a4qluB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C21350C0;
	Wed, 24 Jan 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128844; cv=none; b=pgaKbbz4Kl/Rl4gd2WYRZpXsK7IYhQVg+iNb5xwgqt/tsqAa9ecGO7bIK8kf28j6qHkQm5bbFD4TFRvhZIrrcJvMHMxtMrXwzvCihGNllX5l1FQJoAxrKmL1cW6oDxeCzjP9XWEB664h2sYEWnUpdHAEcQLwlD9ryEl3UspGQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128844; c=relaxed/simple;
	bh=hzJ3DJETdoxLp+P5+lRmaPth2GPIg7sSosK0rWcLIBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=O4okdkvhdfINZUnIIThq+31MPeRTpz6DDJj1BS+ZXej/C+pu2ZS/0OrM0lF6QI9pi1RsWm1pEEOjhePqyGb+ptKqhyXHwr7dNDmPJBDmDr+Dnz2ey16XAhnZU1yLoYhlYxXdxEweTiCzK6T4vksVRDUYy7KikHrMes0aW8H2fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F9a4qluB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OKEpge004717;
	Wed, 24 Jan 2024 20:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6ioIDZv1sGQ7eAng1/+ztxX4+K6ABsfVJQdOjSPqPFo=;
 b=F9a4qluBDv2erKGNQNRZJw4hIXP1QtO//8d/Yd4gluJUQ0rDFJyx5WUAvMS6jWosfzzF
 yB68HafEw0Ts9JF9oJQq7bY/UViDjmSMc57K4nPThh5/TafTMaFOqJT54uR1uvHgKJTs
 xJhubGYuCgIKIq23s0Xw5Eb8xN0uUQ/9KEx6pqqjkluv3dihkevONG2OGrz3ogM9mAFu
 bZmLjwwyOf0shFnTd98uLFjJA3HtIjnVkb17LsueGFyrszO+dBQSSY0W/P+ikkA7lMA2
 jnGH+eGqOd3r2cR1via/p1Yv7ztNKeH0UaYkaQT1E4bPtjJKHeq9pPKOGpRrbms5N1bv vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu7uckhg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 20:40:22 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OKUf7g023282;
	Wed, 24 Jan 2024 20:40:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu7uckhfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 20:40:21 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OIq5BR026879;
	Wed, 24 Jan 2024 20:40:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtgk61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 20:40:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OKeJvM36766408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 20:40:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D61158057;
	Wed, 24 Jan 2024 20:40:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C0B58059;
	Wed, 24 Jan 2024 20:40:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 20:40:17 +0000 (GMT)
Message-ID: <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "paul@paul-moore.com"
	 <paul@paul-moore.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dhowells@redhat.com"
	 <dhowells@redhat.com>,
        "yaelt@google.com" <yaelt@google.com>,
        "serge@hallyn.com"
	 <serge@hallyn.com>,
        "nichen@iscas.ac.cn" <nichen@iscas.ac.cn>,
        "sumit.garg@linaro.org"
	 <sumit.garg@linaro.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Cc: "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>,
        "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "Williams, Dan J"
 <dan.j.williams@intel.com>,
        "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
        "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Date: Wed, 24 Jan 2024 15:40:17 -0500
In-Reply-To: <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
	 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
	 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
	 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
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
X-Proofpoint-GUID: BIDnxhlJRef7AywAZbikE-sp1Jompx04
X-Proofpoint-ORIG-GUID: zbbsiYWRF0oFrQlVwoiL0Xu2qIxYjd_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_09,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240149

On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> On Wed, 2024-01-24 at 14:15 -0500, Mimi Zohar wrote:
> > On Wed, 2024-01-24 at 18:21 +0000, Verma, Vishal L wrote:
> > > On Wed, 2023-11-08 at 07:36 +0000, Chen Ni wrote:
> > > > Add check for strsep() in order to transfer the error.
> > > > 
> > > > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-
> > > > provided decrypted data")
> > > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > > > ---
> > > >  security/keys/encrypted-keys/encrypted.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/security/keys/encrypted-keys/encrypted.c
> > > > b/security/keys/encrypted-keys/encrypted.c
> > > > index 8af2136069d2..76f55dd13cb8 100644
> > > > --- a/security/keys/encrypted-keys/encrypted.c
> > > > +++ b/security/keys/encrypted-keys/encrypted.c
> > > > @@ -237,6 +237,10 @@ static int datablob_parse(char *datablob, const
> > > > char **format,
> > > >  			break;
> > > >  		}
> > > >  		*decrypted_data = strsep(&datablob, " \t");
> > > > +		if (!*decrypted_data) {
> > > > +			pr_info("encrypted_key: decrypted_data is
> > > > missing\n");
> > > > +			break;
> > > > +		}
> > > 
> > > Hello,
> > > 
> > > This patch seems to break keyring usage in CXL and NVDIMM, with the
> > > "decrypted_data is missing" error path being hit. Reverting this commit
> > > fixes the tests. I'm not sure if there are valid scenarios where this is
> > > expected to be empty?
> > > 
> > > Here's an strace snippet of where the error occurs:
> > > 
> > >    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "user", "nvdimm-master", 0) = 76300785
> > >    openat(AT_FDCWD, "/sys/devices/platform/cxl_acpi.0/root0/nvdimm-bridge0/ndbus0/nmem0/state", O_RDONLY|O_CLOEXEC) = 3
> > >    read(3, "idle\n", 1024)                 = 5
> > >    close(3)                                = 0
> > >    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "encrypted", "nvdimm:0", 0) = -1 ENOKEY (Required key not available)
> > >    uname({sysname="Linux", nodename="fedora", ...}) = 0
> > >    newfstatat(AT_FDCWD, "/etc/ndctl/keys/nvdimm_0_fedora.blob", 0x7fff23fbc210, 0) = -1 ENOENT (No such file or directory)
> > >    add_key("encrypted", "nvdimm:0", "new enc32 user:nvdimm-master 32", 31, KEY_SPEC_USER_KEYRING) = -1 EINVAL (Invalid argument)
> > 
> > 
> > Indeed!  The user-provided decrypted data should be optional.   The change needs
> > to be reverted.
> > 
> Ah, thanks for confirming! Would you like me to send a revert patch or
> will you do it?

Revert "KEYS: encrypted: Add check for strsep"
    
This reverts commit b4af096b5df5dd131ab796c79cedc7069d8f4882.
    
New encrypted keys are created either from kernel-generated random
numbers or user-provided decrypted data.  Revert the change requiring
user-provided decrypted data.


Can I add your Reported-by?

Mimi





