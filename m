Return-Path: <linux-kernel+bounces-57377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D2184D7A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12D828623A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882711D693;
	Thu,  8 Feb 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="js2h7UGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D111CD33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707356724; cv=none; b=bNtWNPt0F0KzlQDUl4ePwxCUxF8QvdCQiwyUx+dQhp+0YUKIHGTucysS/51ba67CCKjzIiJ3vGsmCjRO2P1T3XX9NFlmCLK61YGAXVbNd4Oc6iV3rJPipF+zqTYEwrAUgYk3y627QGaMVUf/uv1wa5kCQg3umZ/XDCml4V1goT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707356724; c=relaxed/simple;
	bh=JVBIf2Ulo88/HvjGqKnfEYos35jVYsOVzHizfZ2s6JM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YEbrE2F78QjFxAQ7R2EOYyx6KVk+P5X9666zDYrnCT6DymUaZNm+o8Sh47ZOH0hQ1qhp6qlDoz5de87YYybe/d96qb09qoIlXBnbrbXLjMaSWQ035HinZYBOvJwBXT7nw3rkrdpMpg2Cz6hEe2c3P76zSDt1mXfw6/GvH5AaDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=js2h7UGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC1C433F1;
	Thu,  8 Feb 2024 01:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707356723;
	bh=JVBIf2Ulo88/HvjGqKnfEYos35jVYsOVzHizfZ2s6JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=js2h7UGbeBdMJzWZ05C1L7C/0M9lDD8e7pB80Uw/k90ukxfj7k9VQfAbe5toOtE4W
	 K2QWwXCC1cj3TAMjFTREiZ05n20OozY879NOOqUzIRuYho5CvX7h8ukG22LJUwTnPm
	 Ebr5SguISzJinhC8suLU0B1qaV5wJf8x+69QTjbE=
Date: Wed, 7 Feb 2024 17:45:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Laight
 <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Message-Id: <20240207174522.2d19729ec2e014d521335a04@linux-foundation.org>
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Feb 2024 16:22:49 -0800 Charlie Jenkins <charlie@rivosinc.com> wrote:

> The ip_fast_csum and csum_ipv6_magic tests did not have the data
> types properly casted, and improperly misaligned data.

Neither this nor the two patch's changelogs describe *why* these changes
are needed.  They merely assert that we need to do this.

IOW, when fixing a bug please always describe the user-visible effects
of that bug.


