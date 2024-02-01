Return-Path: <linux-kernel+bounces-49007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFB846498
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961C61F247E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162947F64;
	Thu,  1 Feb 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADI/72Y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F447F57;
	Thu,  1 Feb 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831481; cv=none; b=laFuA6mPPqXpXjAf0WdbZAVDq6z97xpSY0PX4q+eM7a2ivh2AifL0c2A+lQ8WzYJBtLVaAyUWXPoRZxAox3MvNq9+Wr2wM8GPIuRXstZisOwPYzCFhOpBOKegO7Ki2EPPAZq3vjCQIJNc/UfIYm9WFeABkKrElsnFES6NVv8hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831481; c=relaxed/simple;
	bh=vd2d6sHKAqJTlcu+FNSfDZgcz3V3v+EW9kiPJ5h9w/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZlTqftwX6Zg7sfwN0Df6kqbj2787NIAMpYS5U32q7CkUMAgAjmCzy5fRIRPErQtQuh203wj9PdRjDOpoJEReVfEeDRMeBNJNG8mZgnYi5qvbGZEHlAfgv/yTxzuoLPE01j+VjigMRScR4K9Rdk9Z1sDvYujkG682nBvDNupOfvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADI/72Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE58C433F1;
	Thu,  1 Feb 2024 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706831480;
	bh=vd2d6sHKAqJTlcu+FNSfDZgcz3V3v+EW9kiPJ5h9w/c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ADI/72Y8MfJWLyALK1g9tVNMYGblbP2cRRrYOK9AJYjEZUzrMyQ+h31DMhzhWQrzt
	 Wbrf+5EbKF7SC++3ru2Y5gl+POWXTJjt91mNUVLQYKdvEQybnSlbJWLU0vlZqguSxz
	 KndJelCPlASdS5BP19MbQ8v9uxe+bdScqesbYIidC/BpeTouX4udfT8yW7nFwQw9HP
	 5DlGl7e1seNo3JLYEOxEoE2+Fkh4q/tczz1H4FqSqMVLWf86jJMKWgZleka49p+yV0
	 g4/SsOPrfhO8b7zlsjZ1h5xLYG+JZQaOkVvx9QZOK2LVOhfioVLZgTvDk8vprnPfy9
	 4cFxXaXoY/hnw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:51:16 +0200
Message-Id: <CYU59FJIKIK5.1XY6N8ODCZWYI@suppilovahvero>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: make locality handling resilient
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Lino
 Sanfilippo" <l.sanfilippo@kunbus.com>, "Sasha Levin" <sashal@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
 <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>
 <d46abc40-5ad8-4d09-a6f8-f53c4b338142@apertussolutions.com>
In-Reply-To: <d46abc40-5ad8-4d09-a6f8-f53c4b338142@apertussolutions.com>

On Thu Jan 25, 2024 at 2:01 AM EET, Daniel P. Smith wrote:
> > Could you split this up into multiple patches then, so that they can be=
=20
> > discussed separately?
>
> Gladly, but individually none of these fully address the situation.

The total number of scenarios described was exactly zero meaning for us
that a situation does not exist with our current pool of knowledge :-)

I wonder what sort of scenario requires all those changes applied at
once in order to get fixed.

BR, Jarkko

