Return-Path: <linux-kernel+bounces-50606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF54847B81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405C11C24225
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB58175F;
	Fri,  2 Feb 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X65ntk3Y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560A210E0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909320; cv=none; b=YTtpos7cCJigccx7bd3Up+dhqhn2Xhg5ZKUXayvwik9rEjxbUGUDxcVhF3K42JbrUX5UTd2mKNDTXbpwHHYUWZLaGc+7qtQp4plo/CR0YxJWzX+WJkFvl4KR5CGKi09rNPs677FyXC+1t3Lnz5WkXgwESBq6OnrDzjIDbNxVwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909320; c=relaxed/simple;
	bh=XyjPHGndI+MoNCSsW1aIE1c7E7oe1Y7s3NJJa14+lOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAA9ZVZOq4XVA9viWmYvrwFIq/lcALh6cmwfLeM91Qfrf9ZVLZewOtGiT5CQo2HBV/k6IKjAUoc+8JEUOvYknAdpLwH7ISwM2qIKLSjcyH+8+H5ENv6JV/oqHJGfItaCPNwOHLzMxW7oHAw0pfAKzy0hfamtRlvGD7ai+N9HWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X65ntk3Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412LMQDx006438;
	Fri, 2 Feb 2024 21:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=upT5E8WhMh+NpFZBlCi3M+42Wgyud0gZF/cyZtkROsc=;
 b=X65ntk3YyV3vO98fo2eZRKHuwpceBC24S7RxLYGdouicoFNtw/ug4Ud93XHhgH3mpIWa
 i4OmhblNWT2ckGAkaDMwcAz/6NYTpgVRP7GyFCvsplz9A5ibi7IAx2sjUhShPqJPgOFE
 xLzTxzCIu/c6ZtRd9R46v/gYUeC/eB2OxlnP1m/zok6IHUVDjNgqyg2nHqg8X8nC6XyA
 8jFx6FEG7tYsTadWfFOqfXuVsV4wYZ1sWKCZD56yMpNyjyYH+bANrrE+LsIAOI3zZyzQ
 xKHFD+BUTCBv2CAuBi2JHoQ+j1MkHX0IcL21YMm6qIjg+pkCpFwgWz0TanJIEfcbedqs VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w188br3by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 21:28:10 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412LMS21006461;
	Fri, 2 Feb 2024 21:28:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w188br3b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 21:28:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412KXu0k007168;
	Fri, 2 Feb 2024 21:28:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2wgup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 21:28:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412LS8bq20120294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 21:28:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A14058058;
	Fri,  2 Feb 2024 21:28:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B440958057;
	Fri,  2 Feb 2024 21:28:03 +0000 (GMT)
Received: from [172.22.1.223] (unknown [9.67.185.238])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 21:28:03 +0000 (GMT)
Message-ID: <6ccd8c7998542f1ac68514700fb9e31049a3a3c7.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Reshetova, Elena"
 <elena.reshetova@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org"
 <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun"
 <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra,
 Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 02 Feb 2024 22:28:01 +0100
In-Reply-To: <20240202160515.GC119530@mit.edu>
References: 
	<DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
	 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
	 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
	 <20240131171042.GA2371371@mit.edu>
	 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
	 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
	 <20240201045710.GD2356784@mit.edu>
	 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
	 <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com>
	 <20240202160515.GC119530@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aE7ZWHsxFs8wPydSK9e4wmzWrzuxXahb
X-Proofpoint-ORIG-GUID: qTUk9b7EiQk_odhnwMryDIq1QGThG6DZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020158

On Fri, 2024-02-02 at 11:05 -0500, Theodore Ts'o wrote:
> On Fri, Feb 02, 2024 at 04:47:11PM +0100, James Bottomley wrote:
> > 
> > It's a lot to quote, so I cut it, but all of your solutions assume
> > a rdseed/rdrand failure equates to a system one but it really
> > doesn't: in most systems there are other entropy sources.  In
> > confidential computing it is an issue because we have no other
> > trusted sources. The problem with picking on rdseed/rdrand is that
> > there are bound to be older CP s somewhere that have rng generation
> > bugs that this will
> > expose.
> 
> I'm not sure what you're concerned about.  As far as I know, all of
> the CPU's have some variant of Confidential Compute have some kind of
> RDRAND-like command.  And while we're using the term RDRAND, I'd
> extend this to any CPU architecture-level RNG instruction which can
> return failure if it is subject to exhaustion attacks.

My big concern is older cpus where rdrand/rdseed don't produce useful
entropy.  Exhaustion attacks are going to be largely against VMs not
physical systems, so I worry about physical systems with older CPUs
that might have rdrand issues which then trip our Confidential
Computing checks.


> > How about making the failure contingent on the entropy pool
> > not having any entropy when the first random number is requested?
> 
> We have tried to avoid characterizing entropy sources as "valid" or
> "invalid".  First of all, it's rarely quite so black-and-white.
> Something which is vulnerable to someone who can spy on inter-packet
> arrival times by having a hardware tap between the CPU and the
> network switch, or a wireless radio right next to the device being
> attacked, might not be easily carried out by someone who doesn't have
> local physical access.
> 
> So we may be measuring various things that might or might not have
> "entropy".  In the case of Confidential Compute, we have declared
> that none of those other sources constitute "entropy".  But that's
> not a decision that can be made by the computer, or at least until
> we've tracked the AGI problem.  (At which point, we might have other
> problems --- "I'm sorry, I'm afraid I can't do that.")

The signal for rdseed failing is fairly clear, so if the node has other
entropy sources, it should continue otherwise it should signal failure.
Figuring out how a confidential computing environment signals that
failure is TBD.

James


