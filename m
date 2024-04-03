Return-Path: <linux-kernel+bounces-129685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983B896E64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2DB1C26A62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2114386F;
	Wed,  3 Apr 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPhhYlmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F815134CCA;
	Wed,  3 Apr 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144587; cv=none; b=TmsAkkBMEsaLbQKeoSp2TIaZTFyy9J18VW+HMonkppdzrXZ4QvkA3PvGis7QcS+abZX6jWgGbY6Q8zqqJ93Iev0nUdMhenonk+hUW9pobwvZPwvIVYv0TY50LFBQ7j9DrZCkB3inza9eqvn+dBjXgApMbEeluN2V9zZBO0wCf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144587; c=relaxed/simple;
	bh=eA8Jo6KB5j4TiA4T4QzdOaHhNZAtLwK1UcyMKg3fUsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K7w6aTvRYBJICWohbYM+LKVEDAf4QXv+dtvjBxi+lnStqZs0P0VO/UDSkLmIoerliMkHTPClUy8A8RlYNUHWpwp/WJHTHiD5MwPztG7OPKvhhuBOAULrhBCxCicHcCncGSjywxMG1x5Ol7pCf3QZSFX+fiUCIhure77n1rpKYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPhhYlmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4256C433F1;
	Wed,  3 Apr 2024 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144587;
	bh=eA8Jo6KB5j4TiA4T4QzdOaHhNZAtLwK1UcyMKg3fUsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GPhhYlmCEFQojfDQ/HcliPklypTOAqQvqjYWYdMOfEKncnhclxdlYoPDm/QC9IB4X
	 JzHJMgmXgItpf9fbnTLqYFMIaTukpwESgfE/Rmsf1AQp6Adqo7KzzZu0a1eUfNSTPJ
	 qH75mCZ8SvfuTtSMzlQWg0UhIzTl+7yV8l5Tmke2l+ST720G2fuTNAKY63y4WcdYP5
	 ZcqfULb/2s8eDasjyRiuCHNqdQMNcYIMgFe9j3TNYPxP6zVrlgHap2u+ViUmKeeFjY
	 3wdna9AN2chjgmMtMcRO9ATX9CBvkmR4J8OnJW8hITo7DPDqxXrS+Gri1ELYjby6n9
	 BSXoltSCE/c8w==
Date: Wed, 3 Apr 2024 13:43:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
cc: linux-kernel@vger.kernel.org, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
    =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH v4 1/4] HID: hid-picolcd*: Convert sprintf() family to
 sysfs_emit() family
In-Reply-To: <20240319054527.1581299-1-lizhijian@fujitsu.com>
Message-ID: <nycvar.YFH.7.76.2404031342530.20263@cbobk.fhfr.pm>
References: <20240319054527.1581299-1-lizhijian@fujitsu.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

I have now applied the series, thanks.

-- 
Jiri Kosina
SUSE Labs


