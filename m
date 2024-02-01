Return-Path: <linux-kernel+bounces-48960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE68463CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660D28F060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0D46424;
	Thu,  1 Feb 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koUpsizu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217145BF3;
	Thu,  1 Feb 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827752; cv=none; b=eVqvAG2RSFYZItSX1rRYDTKg4mRLJUgOCwMvCVo1CjA+xWCvuRa2capv5/Ovl8TC4wG1OByyyX7gcjvYbCvHj9BfLkeX726DKuv9W+lJwUtzCDsmc2gPLzyu6gfJmIowRci/gvJUb0l7O95Xd7xVxWs5icWF7QJTBbJUYgwcilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827752; c=relaxed/simple;
	bh=0je2dxr7BXmUItHtp4z0LdubNofc/+icVPauw/bIGug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GvjVs1JDk1zIRT1lfWAQExFvGpq1frChZvWHrpFh2/MyuA1AP3FxOEd/C5ePDyigMrOwPj2VlGNdjWVfdoCqE/FMqmJ0kocqp/DoA1vtZNQ5WQ2tc4LzR+vXU1A6QBJrkRWEKgubie4NyiOekwj7qtEd7nvIrcgLDHHCXNbc/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koUpsizu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4BC433F1;
	Thu,  1 Feb 2024 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706827750;
	bh=0je2dxr7BXmUItHtp4z0LdubNofc/+icVPauw/bIGug=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=koUpsizufBcW9LBm0ihUy6CYPMJZ6q57Jn7vsA7V/hd46xiMgIekElFW8zIl1Zqg9
	 sCwgmkDEilY9DiHSWe5efBTcxnHgxFhuud+oqx3lkHjHiPfC31Vud7IckfRODcsk5W
	 obM1bma2Y1zWPJ8svc8gLLOGwWoaX1NZ86StDOzMAx8ExWbKhckD3vOwbh4jhi4Lqd
	 WZtXEQoJoyDGfuFtOd/XuV2ZmkV13d/ke9fXdmaLwdN5nicTJoCeBRPo9ZRDX8OElm
	 VkYwv6pWGqMmBzkRkUngZGhDjJ6NpSS/JY5xdFtYlQz2t6s+7xGZBrI1UPpXJ5byGg
	 f6MX4k7hd8odg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:49:07 +0200
Message-Id: <CYU3XUGOX6QT.1GL070ONNPBWQ@suppilovahvero>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Subject: Re: [PATCH 3/3] tpm: make locality request return value consistent
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-4-dpsmith@apertussolutions.com>
In-Reply-To: <20240131170824.6183-4-dpsmith@apertussolutions.com>

On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> The function tpm_tis_request_locality() is expected to return the localit=
y
> value that was requested, or a negative error code upon failure. If it is=
 called
> while locality_count of struct tis_data is non-zero, no actual locality r=
equest
> will be sent. Because the ret variable is initially set to 0, the
> locality_count will still get increased, and the function will return 0. =
For a
> caller, this would indicate that locality 0 was successfully requested an=
d not
> the state changes just mentioned.
>
> Additionally, the function __tpm_tis_request_locality() provides inconsis=
tent
> error codes. It will provide either a failed IO write or a -1 should it h=
ave
> timed out waiting for locality request to succeed.
>
> This commit changes __tpm_tis_request_locality() to return valid negative=
 error
> codes to reflect the reason it fails. It then adjusts the return value ch=
eck in
> tpm_tis_request_locality() to check for a non-negative return value befor=
e
> incrementing locality_cout. In addition, the initial value of the ret val=
ue is
> set to a negative error to ensure the check does not pass if
> __tpm_tis_request_locality() is not called.

This is way way too abtract explanation and since I don't honestly
understand what I'm reading, the code changes look bunch of arbitrary
changes with no sound logic as a whole.

Please do not add more text to it. Instead write something more
understandable.

Again, we would need a legit scenario for each and any return value
change.<F49>

BR, Jarkko

