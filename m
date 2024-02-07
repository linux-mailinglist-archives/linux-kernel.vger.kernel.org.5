Return-Path: <linux-kernel+bounces-56379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CB84C97C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185361C25C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3F18EBB;
	Wed,  7 Feb 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4RlBcm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1451B7F2;
	Wed,  7 Feb 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304683; cv=none; b=fz2FVUbVQCQ1ITolVXwXeM9HkaZDuSgL8iww70LLCk/YVm6mpOnqOJNz14G09ZFgMwnzeAR4TLR3xpvCR/myT7kvoKl6CFbbrNigkblmhl8kJZ/nYPY60Yudc+va+CUxxQpw7QYKcwoXKfLra2MgB/0QmgrDVFP97KvuJyIsmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304683; c=relaxed/simple;
	bh=xmiZrYRxLnJlnMLs1bZ4Gdpk1VKKRQZbSJyawdxBg30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVUc6Lc+cDxpOtIFk1ROOkrP+yEgZU/nqT8eFGoQ2bv1pFFyyFw4urebSRllJ/RtJ0icIuIqoNzt6dVR5dK+zJ655hZlgD7ncMxnwxH2celFSUv9DxP4z8qxECUlLiKwUqJDwZ0SoHkg9YJUJ/gzYf5Yk5rlvfFM4htGcmfU/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4RlBcm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A991C43394;
	Wed,  7 Feb 2024 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707304682;
	bh=xmiZrYRxLnJlnMLs1bZ4Gdpk1VKKRQZbSJyawdxBg30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4RlBcm6dAq3HbU103w7LDHctDPZJ/A8mrPOOzknAc/IoNpn0MGDFReBWJBgbf5rY
	 2NgOh7VGW9R7sIiqoF/V87FlQzDrRqnjtJrwlqM5CWOSc0UPEzjor8wjbxOs+4eYeh
	 j9saer13C5rihh9KUB46DWxQfCzebqD+QFp5+FdxmdzkhiMKmXfRlTpCWhmqbzuNi6
	 pxb5FtpD5+2LBEJztmOygFoV83cGh1ZMtOdjIzYkPJT4AmyE5aiGqwVdBS6JzUuLZj
	 MidgtNbdRApMmMQccuuuXh0ph5Bi8it4K0BnUAA1kwLKZ/3lcCrlIhgK14Up0LtQbQ
	 W5t3DAzU5ij5A==
Date: Wed, 7 Feb 2024 12:17:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207-unvorbereitet-drama-27d6b5f7c877@brauner>
References: <20240206192357.81942-1-tycho@tycho.pizza>
 <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
 <20240207-daran-fliesen-6039a2e36f39@brauner>
 <20240207-blumen-neulich-f1507e0c5cc0@brauner>
 <20240207103201.GB6627@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207103201.GB6627@redhat.com>

On Wed, Feb 07, 2024 at 11:32:01AM +0100, Oleg Nesterov wrote:
> On 02/07, Christian Brauner wrote:
> >
> > So this is what I have applied currently where I moved the check into
> > __pidfd_fget() where it makes more sense imho. But please double check
> > that I didn't mess anything up:
> 
> LGTM.
> 
> You have already applied this patch, no need to add my ack, but FWIW
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Added. Thank you!

