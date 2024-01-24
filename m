Return-Path: <linux-kernel+bounces-37583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C07683B1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF91F2348D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED1132C03;
	Wed, 24 Jan 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ckLsljpW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECD131E3F;
	Wed, 24 Jan 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123735; cv=none; b=JQ7ZJ9cCqfBMFqZ9DNrKOvbnsWBiUmOvRARQZgJ9iosQzpLCOokJ85bimmpGAp8GB/XG2nXo5qK0B57TUvQ0IcM76Ci7GEyUB/fl86xFYXEtnBEOnoF2f6tejF5xJ4UnisW/GHGC2D0RIvRYulUUoeztyTdwmiI3jluOcmzFUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123735; c=relaxed/simple;
	bh=B08zH/Zj1+9947BVC11cIyrY/ngZ/ruph/VVkiK0hNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=OtJ5yxRQlXGHT2+kpvklH1NoR0XUwDqqP38PVWqIM2yVcB1fmrcs2VuEMWFdSdxM9ai3ClLhP9uiRmX6sOEmnqtRCghzZTFM7ToVn9hqmo7eK/w0AKN1Adz6swehyGtcR08heZG2ieA7RIRl5TQKzhMNjIuCX0OFxYRAgllurjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ckLsljpW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OHt8rJ004557;
	Wed, 24 Jan 2024 19:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zo2++ACo49EP1hg4v+i0b/fmcpX8GWHs1XosBj/tyas=;
 b=ckLsljpWuNHFuXXKUmzCVOs42rA2JXjE9UEuso+I56Z7iQp7uw+BPC2rAhfLDT5Pglku
 STFZ0a2KINBNfSeHfH8RaZgWXpROKoMumQIDNi1+aFWj3OlXfIAD2ZGPH+BZQe/nX/uV
 iH95Z1qqnfbZ8YG5UBFTD7CreftRe6tV8YMTeS0jIlzvFDjV8c1qU1h5YhIRPst8H57N
 1AmrYEvepV+tzp98Hrpec0CIH8qcCqzPRGGRhyYFIVtV++ZayXoMtUGA/k8H6H6A8Qbq
 nxTbDWnYldjYzy6EJ1MFX91dqbnnsCUr0l+1IYwiZzPYIwX0M2Di7+yMDBdy2w15lfuo 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu555evp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:15:10 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OJENUt026901;
	Wed, 24 Jan 2024 19:15:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu555evn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:15:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OHVRs7025277;
	Wed, 24 Jan 2024 19:15:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkfg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:15:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OJF8ZX11272900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 19:15:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EECEE5805B;
	Wed, 24 Jan 2024 19:15:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78C6D5805E;
	Wed, 24 Jan 2024 19:15:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 19:15:06 +0000 (GMT)
Message-ID: <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
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
Date: Wed, 24 Jan 2024 14:15:06 -0500
In-Reply-To: <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
	 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
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
X-Proofpoint-GUID: XbDQIoDPUYaXI1yarCM4UyG2x0hGLH0o
X-Proofpoint-ORIG-GUID: Aau8_QBj0RNaQ5BaqOg41OD8vQI2QeHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_08,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240139

On Wed, 2024-01-24 at 18:21 +0000, Verma, Vishal L wrote:
> On Wed, 2023-11-08 at 07:36 +0000, Chen Ni wrote:
> > Add check for strsep() in order to transfer the error.
> > 
> > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-
> > provided decrypted data")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >  security/keys/encrypted-keys/encrypted.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/security/keys/encrypted-keys/encrypted.c
> > b/security/keys/encrypted-keys/encrypted.c
> > index 8af2136069d2..76f55dd13cb8 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -237,6 +237,10 @@ static int datablob_parse(char *datablob, const
> > char **format,
> >  			break;
> >  		}
> >  		*decrypted_data = strsep(&datablob, " \t");
> > +		if (!*decrypted_data) {
> > +			pr_info("encrypted_key: decrypted_data is
> > missing\n");
> > +			break;
> > +		}
> 
> Hello,
> 
> This patch seems to break keyring usage in CXL and NVDIMM, with the
> "decrypted_data is missing" error path being hit. Reverting this commit
> fixes the tests. I'm not sure if there are valid scenarios where this is
> expected to be empty?
> 
> Here's an strace snippet of where the error occurs:
> 
>    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "user", "nvdimm-master", 0) = 76300785
>    openat(AT_FDCWD, "/sys/devices/platform/cxl_acpi.0/root0/nvdimm-bridge0/ndbus0/nmem0/state", O_RDONLY|O_CLOEXEC) = 3
>    read(3, "idle\n", 1024)                 = 5
>    close(3)                                = 0
>    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "encrypted", "nvdimm:0", 0) = -1 ENOKEY (Required key not available)
>    uname({sysname="Linux", nodename="fedora", ...}) = 0
>    newfstatat(AT_FDCWD, "/etc/ndctl/keys/nvdimm_0_fedora.blob", 0x7fff23fbc210, 0) = -1 ENOENT (No such file or directory)
>    add_key("encrypted", "nvdimm:0", "new enc32 user:nvdimm-master 32", 31, KEY_SPEC_USER_KEYRING) = -1 EINVAL (Invalid argument)


Indeed!  The user-provided decrypted data should be optional.   The change needs
to be reverted.

thanks,

Mimi


