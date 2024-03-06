Return-Path: <linux-kernel+bounces-93169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9D872BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E31C2194A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B6C8C7;
	Wed,  6 Mar 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR6TeWyz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CF846B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684986; cv=none; b=TFFuXc8Ei0wOEAOi35pzI5ROOGg9aRHD96IW6knGpB5SHIjD6y0+Ospm9IlZMrZyPs70zwbT+PhBnJEuN38Z+IBHrjXAxRSgt6Y31lelzQzhd+s1EN0jn4KPVFTNXBlgVFPJshuvkLlOrpfGmfstCl4qcAKEOU+5CamY61vGOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684986; c=relaxed/simple;
	bh=3TGXNtbSnGqUmrRKGS4Vxyjh7otthNXIvoCLbmKVZJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YlNfoKe9/Z3gflQaa2Cvu9Uhfv3qPQEEpL0DlXkCCQTcQ9XUvaq6xczaum8Zrx4eOi7CJU0nUPW94Vw+23knwlAPpkTftYPvCHHx81tAyzugiOZKn+dIlTCDIcH8tmnSCVfDv9U4wPBRgYgDLlcBiK0/HDZ9oiIHMbBTVUx5qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR6TeWyz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so9423486276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709684984; x=1710289784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSB6RmxldMWGsQwbWc2w1sJWlx2GAlKRYfswIj2uSas=;
        b=ZR6TeWyzKG5mLn3oMZfBsFNK5HN82QByxp6RoHYJqxfk6KgS3YdwGsr4GSnd3fU7Ii
         e8Lf9y+l+OcelcjWqAPE5+YCzk19fj0sCK/YGYz5ttIIo9x3FTtQ4o2OYxXXEQzu9rBx
         kgB+RIKw5KgYuKGKKwMO5/pP/zgDgPxHfwCm6tZfQlbVuAqSL5DdnWIEmATCIE6hoitC
         irEmkUO5pdi0Q8c5vxEal8nV6BXu6XyV1K4mLp7V1ociUnUGHn34TvsSxip/2B3ZxIec
         3UX8Etjayt0ljbPswzBiw/cVdeLY5IphgRFFsFu+7VR5ty884zmDY0Yy6GcrdFvRPL3g
         QqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684984; x=1710289784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSB6RmxldMWGsQwbWc2w1sJWlx2GAlKRYfswIj2uSas=;
        b=r+xfKjO6woqbGt+zLfLSEiCzJoaI0U4opWi3GYl/SoRPN5YVG9MdB39LtL7mPxi84e
         q/Zq8kpmKQP0NbC0ErwHLnNiGdur7eZq8clu1h8CJWc6uBDLsGKdg4yxqzL3nAaINkTy
         TdOz28Q92VmByEszDL0LMjr1p+Akub11k6R6/sPq6NTGe3FtMT5aDfe9dojgDZihJ6A5
         UeYpcE5ynEL1C3YgF0oglWyV6sjBg5SSxaza82DpA3f9RXn1sxHnhvmYtGubF87/O2yl
         Tj9XQTjVMCyvftJpn6oQeeubfghnWv6mr1WUNGlXAu9i3Ztyp4oDlkq1J6S2zT18B22M
         WsZg==
X-Gm-Message-State: AOJu0Yy3WwpDFLXnHuMrdtjCQXp0JCeR13WZoVydOBe8XnOyQ2d+st9r
	pGg4kHhY3gwFH/SML6FGFRGvpylfJVhfAjCq9c4jLVZevNQRwbvQ3Bq4k/dbrStnBjunH2Q2bft
	/2w==
X-Google-Smtp-Source: AGHT+IHq9WdopNkqHirkj1ZNnJCotQ7fHu7uj+p8bztDqe+dPoiGmxwesLZ6INERbKQTG2EJNzDhuuJ1Pgk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr589896ybe.8.1709684983800; Tue, 05 Mar
 2024 16:29:43 -0800 (PST)
Date: Tue,  5 Mar 2024 16:29:35 -0800
In-Reply-To: <20240227015716.27284-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227015716.27284-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170967423579.413845.13663361620906682493.b4-ty@google.com>
Subject: Re: [PATCH 1/1] KVM: selftests: close the memfd in some gmem tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 26 Feb 2024 17:57:16 -0800, Dongli Zhang wrote:
> Add the missing close(fd) in guest_memfd_test.c and
> private_mem_conversions_test.c.

Applied to kvm-x86 selftests, with a massaged changelog.  Thanks!

[1/1] KVM: selftests: Explicitly close guest_memfd files in some gmem tests
      https://github.com/kvm-x86/linux/commit/e9da6f08edb0

--
https://github.com/kvm-x86/linux/tree/next

