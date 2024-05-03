Return-Path: <linux-kernel+bounces-167337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB48BA821
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1E6282978
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D81482EC;
	Fri,  3 May 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTsX1+O+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169C12B89;
	Fri,  3 May 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722928; cv=none; b=tdWtHsvfdymUKzG+ZGrOh4bHh3rUpGU4WzntAxHv30tH4fqAxsq1JrkReJCH/7QqDm8ZjJHpdQFwxRYPt/sBrW+Lr5vLlGBrhJCtxb/AJZsIAx9wbeYEqY+tjEhLLCsenpWTUrNHmxRIP/gGSlCrgNad1aiLc+9ir5dEx1UYRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722928; c=relaxed/simple;
	bh=yojA61f3TtJGPtJOIsjSGNe4XU32tQPgeWdkDlvF0mU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GimUv6YCptZc3+uK1KNpzjXaTsKoApcGihOVBkHV46Z6U7ypFH7dSzpduUGMvP380zzwU8C56VttQczrhzJhHNbCeere9eFAh7TxFvx9hMKEo9FYBhK8qXoOZvkZd1RmO/yVGIeWaruvdNU2qRBD9Gi0PFvC8vt+9qqhU+BLL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTsX1+O+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4437ZOLr001313;
	Fri, 3 May 2024 07:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ICDaggG/gXeTRB72xqxW3n+JXQUcDwKM9WB6+j4TVjQ=;
 b=rTsX1+O+VgpZCCWC5Sr/sdnxV8vBrEqHM2xD5c1UKbkXMD0+UljwPYK1La/Ya+WDLM14
 1kVdCTWWqA3vzo9pNY8fo4W5Ygk/hQSMucxlyWS4zxC1Wpj29s+AI5RNP3MiKeQFmoDs
 ScM61ZPNuYqHsFZrrh2Iv+MYoXVIFg+j8sdH/HyvoupHChqPrT84383TP6l9m72jvTgH
 6sKzJUmhh6AyUkv7fWFGy+lPrXCfQX2/nA1iioyF3a2QyaFI94BfrNt6hlNW2Zwny5Ue
 W09CmbPN6GZMkpoj9++6x5XO0ISwXI6kpSWj+HaoICR9rOfDELyGikm/QTr/fpXM0R8Y 5g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvuhy01nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:55:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4437H6B2011769;
	Fri, 3 May 2024 07:55:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwmm77w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:55:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4437tDxg17105334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 07:55:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A72EA2004B;
	Fri,  3 May 2024 07:55:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D86F20043;
	Fri,  3 May 2024 07:55:13 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 May 2024 07:55:13 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.150.11.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 55F406109C;
	Fri,  3 May 2024 17:55:07 +1000 (AEST)
Message-ID: <2492716e18c515e21b855305c0bc760057dbcf7a.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: manoj@linux.ibm.com, ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Date: Fri, 03 May 2024 17:55:03 +1000
In-Reply-To: <33cf08b4fe751af156b1a7c17f69a0ca37dc5eed.camel@linux.ibm.com>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
	 <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse>
	 <33cf08b4fe751af156b1a7c17f69a0ca37dc5eed.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O3ITnM5Exdb-zeuEU-fV7oRMwwQWOrP4
X-Proofpoint-GUID: O3ITnM5Exdb-zeuEU-fV7oRMwwQWOrP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=876 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030056

On Fri, 2024-05-03 at 13:15 +1000, Andrew Donnellan wrote:
> This doesn't seem quite right to me, I don't think we can just
> redefine
> CONFIG_CXL as a bool, but I'll do something like this. Probably won't
> bother for CXLFLASH since they'll see it for CXL anyway, but I might
> add a warning message on probe to both drivers.

The more I look at how to do this, the more issues I see, though
perhaps because I personally use olddefconfig more than I use
oldconfig.

Without changing the default to n, running olddefconfig is liable to
switch CXL back on in configs where the user has disabled it.

Conversely, if the user has set CXL=3Dy rather than CXL=3Dm, I'm not sure
if there's any way to make it such that olddefconfig doesn't reset one
symbol or the other to the default m.

Honestly, I'm very tempted to be a little more aggressive and a) not
bother with trying to play games with symbols, b) change the default to
n in this release, c) add a warning printed on probe, and see whether
anyone complains.

We could also print a message during the build itself, though that kind
of noise is liable to break things in other ways?

It would be kind of nice if kbuild had some way to mark a symbol for
deprecation which could print a warning during configuration.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

