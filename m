Return-Path: <linux-kernel+bounces-133527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283289A4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DF41F22CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B42173328;
	Fri,  5 Apr 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfu4urZC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF54171E66;
	Fri,  5 Apr 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345233; cv=none; b=W5QNx6JFrt1b1PbmFMcuIGuykkQgiGDCfFRdYonVARCNnsvhduurhoE4JPsxKyhARutSivRv74p6MCXWmH8L2WJX9gSn7HGeFSaIyLuZiHHzNMJhELCgBNxTYbB6y3fGWx8HX2AJwL97ci9BncNw0Lky4I2jcRbuGHnZdmf1vAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345233; c=relaxed/simple;
	bh=9MAfNCdXjZ7MvFy1sX8jZnS5coKpSmbLX2zwmqg5sD4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n545azt62r2hTROpe41UJjFw88WGNny+AbHNnhqk3fHtuI0DHE1SZ9+I2dQ1hH/UpmD7zIbKsevm8QnB+YgOWzAAC+wP+xKHloujNcvNBjvfAQWGmKatSn1lfhgGPL1P/fioVQQRppOXYw9abh1mGODYCGeHu6cMAZm/RquxZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfu4urZC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435JBQpG024733;
	Fri, 5 Apr 2024 19:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=3le9rQCxMCB8AWK5g1sXl
	Gm8iA0NlfByaP1nbQYaYj4=; b=cfu4urZCZDxK95lbj6Wt+VD0hC+E58GlpOrpM
	U861cLAdLfnke9yRhgVk8Nm1XXVNcBofNq1DUxACkQYRKQcdrIgWd6hJ4icfHk7X
	b0S+qG2dd3TkmUcwxv9nSMFPwkM5WyTW45ToSMRuIoQXMnEkaHV7S0BRYZwLmeIU
	P7TrzGsR5RYCLrLAbCOd7PbcWbN4GTSkA1lAjwF5g5EZ4gqHdhpH7JjBCvgHDHDl
	p9eLsL7gtlaXk9BChpvj0oEAD245Y2/t0fRAf8q6RA2kcwBkXFGY/bZAnSw4o4LI
	Y6iF4Ka3uRuaeOtX0smQhcfeAN2YQSz+X2gJ+LIjr0mqPKABQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ejae5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:27:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JR4XD003171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:27:04 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:27:03 -0700
Date: Fri, 5 Apr 2024 12:27:02 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold
	<johan@kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v19 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZhBQhvieHGtMOSEz@hu-bjorande-lv.qualcomm.com>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
 <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
 <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>
 <2024040455-sitting-dictator-170c@gregkh>
 <Zg9THGBRuppfw4y+@hu-bjorande-lv.qualcomm.com>
 <2024040558-undercut-sandbar-7ffc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024040558-undercut-sandbar-7ffc@gregkh>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qXIF4YI4Svza1UT6WakBYlWAM40FTP_m
X-Proofpoint-GUID: qXIF4YI4Svza1UT6WakBYlWAM40FTP_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050137

On Fri, Apr 05, 2024 at 06:43:56AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 04, 2024 at 06:25:48PM -0700, Bjorn Andersson wrote:
> > On Thu, Apr 04, 2024 at 02:58:29PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Apr 04, 2024 at 10:07:27AM +0200, Krzysztof Kozlowski wrote:
> > > > On 04/04/2024 09:21, Johan Hovold wrote:
> > > > > On Thu, Apr 04, 2024 at 10:42:22AM +0530, Krishna Kurapati wrote:
> > > > >  
> > > > >> +static int dwc3_get_num_ports(struct dwc3 *dwc)
> > > > >> +{
> > > > >> +	void __iomem *base;
> > > > >> +	u8 major_revision;
> > > > >> +	u32 offset;
> > > > >> +	u32 val;
> > > > >> +
> > > > >> +	/*
> > > > >> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> > > > >> +	 * needed to get information on number of ports present.
> > > > >> +	 */
> > > > >> +	base = ioremap(dwc->xhci_resources[0].start,
> > > > >> +		       resource_size(&dwc->xhci_resources[0]));
> > > > >> +	if (!base)
> > > > >> +		return PTR_ERR(base);
> > > > > 
> > > > > This is obviously still broken. You need to update the return value as
> > > > > well.
> > > > > 
> > > > > Fix in v20.
> > > > 
> > > > If one patchset reaches 20 versions, I think it is time to stop and
> > > > really think from the beginning, why issues keep appearing and reviewers
> > > > are still not happy.
> > > > 
> > > > Maybe you did not perform extensive internal review, which you are
> > > > encouraged to by your own internal policies, AFAIR. Before posting next
> > > > version, please really get some internal review first.
> > > 
> > > Also get those internal reviewers to sign-off on the commits and have
> > > that show up when you post them next.  That way they are also
> > > responsible for this patchset, it's not fair that they are making you do
> > > all the work here :)
> > > 
> > 
> > I like this idea and I'm open to us changing our way of handling this.
> > 
> > But unless such internal review brings significant input to the
> > development I'd say a s-o-b would take the credit from the actual
> > author.
> 
> It does not do that at all.  It provides proof that someone else has
> reviewed it and agrees with it.  Think of it as a "path of blame" for
> when things go bad (i.e. there is a bug in the submission.)  Putting
> your name on it makes you take responsibility if that happens.
> 

Right, this is why I like your idea.

But as s-o-b either builds a trail of who handled the patch, or reflects
that it was co-authored by multiple people, I don't think either one
properly reflects reality.

> > We've discussed a few times about carrying Reviewed-by et al from the
> > internal reviews, but as maintainer I dislike this because I'd have no
> > way to know if a r-b on vN means the patch was reviewed, or if it was
> > just "accidentally" carried from v(N-1).
> > But it might be worth this risk, is this something you think would be
> > appropriate?
> 
> For some companies we REQUIRE this to happen due to low-quality
> submissions and waste of reviewer's time.  Based on the track record
> here for some of these patchsets, hopefully it doesn't become a
> requirement for this company as well :)
> 

Interesting, I was under the impression that we (maintainers) didn't
want such internally originating tags.

If that's not the case, then I'd be happy to adjust our internal
guidelines.

Regards,
Bjorn

