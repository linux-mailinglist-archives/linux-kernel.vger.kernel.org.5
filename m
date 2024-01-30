Return-Path: <linux-kernel+bounces-45039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB2842AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66372869A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C512A145;
	Tue, 30 Jan 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6GYPm23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9D1292CD;
	Tue, 30 Jan 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635668; cv=none; b=dnZEEHf7l0rd77lSvfBDrqkgIUONK9DUNBIo0yihaKieVktExAdBrYLuPPlRcH1563BCWvf8Iz6aj9KotBa/nLvtRfHK3krWnHciHCl2YG5ULJAl0nnND26BGdGlrg0ONd4pdd+eo6Or7382x7sM9F80117yi/fQfxeOilNAlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635668; c=relaxed/simple;
	bh=ExHtMHFhc8+GQs5GVCQvMdASt/COJfq1w+DGLLm9XZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BDrQA4EWoODL2j+lGrgrXcfpTPp1VbMrnTbLQbLGlA7z9hXZB35eMB8DtGfA6+gyDp+2akkP26ddtZXxnq8EOH9RP/ZwKuUD3Pub6VOCyNJkl/oUfQjjN6s6YvoqJ+aWUZhDNxzan4kyetNSPu4YvEV2klzjOhjIVYhGZfXUH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6GYPm23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE39C433C7;
	Tue, 30 Jan 2024 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635667;
	bh=ExHtMHFhc8+GQs5GVCQvMdASt/COJfq1w+DGLLm9XZ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=O6GYPm23K0wHcpG9+FscQZSa3zkVBqEKNKkUgCVD0J/eW2tS4hAj3N8LzFf06jlYj
	 54ALyOQKZIRTk34+IUTE0FNqYdzwaGqy2RnCLb10oNijhs5CP+iKUzlqQHM/73RkU+
	 Mo5ALXyFCSWnRraFJxUDICDfKhJvGUiiktoPoG7Xtfpu4+c+Nh8lCQJXxE8/WTu9Pt
	 ajbeBE6ZG7PL8TVT+lPxjsU0p2gCoQ1lAmG2hrhDW4AjvuZ16bovvuA0DN1wBMX1Sw
	 Bv38Il+WtB8A5xYTAHqufan1SiMLWS+6yd1ff8Ezf3PHL0sgG81oFsCciUeLcjj53r
	 2AUt/nHbYoKsA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 19:27:44 +0200
Message-Id: <CYS7UOQQ3L7P.2V7HDL1U2VOD4@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Luis Henriques" <lhenriques@suse.de>, "David Howells"
 <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240130101344.28936-1-lhenriques@suse.de>
In-Reply-To: <20240130101344.28936-1-lhenriques@suse.de>

On Tue Jan 30, 2024 at 12:13 PM EET, Luis Henriques wrote:
> Delaying key quotas update when key's refcount reaches 0 in key_put() has
> been causing some issues in fscrypt testing, specifically in fstest
> generic/581.  This commit fixes this test flakiness by dealing with the
> quotas immediately, and leaving all the other clean-ups to the key garbag=
e
> collector.
>
> This is done by moving the updates to the qnkeys and qnbytes fields in
> struct key_user from key_gc_unused_keys() into key_put().  Unfortunately,
> this also means that we need to switch to the irq-version of the spinlock
> that protects these fields and use spin_lock_{irqsave,irqrestore} in all =
the
> code that touches these fields.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

OK this is great. I mean in this commit it is pretty essentiual to
document that there is an ownership change. Such changes have by
far the biggest impact to kernel semantics, and thus very useful
to mark such commits for e.g. bisection.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

