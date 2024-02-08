Return-Path: <linux-kernel+bounces-57416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41B84D8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FF01F236D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B016374EF;
	Thu,  8 Feb 2024 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CwOBYXWY"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368382577B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362324; cv=none; b=K4xGb1bRLcFIrPl2WbQBvI62gThDWTJNOW69RVrxwP94jHzyXfEvC7iTH2v5elz4Loa8A5KvLkyM3FUlpEsWyVQkxawyGSjEsJNewL7ahbDwH6TBZn40GpTcpgvkqn0rNRXOqbW/0XTeVm41j6zKXuFGZdlePNoh1OvSNaDdtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362324; c=relaxed/simple;
	bh=6dQGPNZAgQk3XqwfbdpS8WaIUWpphTPHXuoWY2kkp00=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=U6vx3WsVaN/VD8mBssKmv/LeHdgExPRY1SgzmC+z2Yfw5+FZB1BrRzCgWSEc0EtyGOkp3uOUIsiChz/MOfhrw7tK3ju8fcMhUIbWvGQ5454y1D5g8vcdGElwayvUe+aTbgTYDRLl/IeEyW1cxIKK+FXmDgqsAOYwpXRSIHeC5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CwOBYXWY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a9f0f1d40so6301561cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362319; x=1707967119; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIE1KqS+DFaPo+w+SIvDjHcTCcgNUuxxYztbzhygZA0=;
        b=CwOBYXWYNQ8tEceluNkWygdecyKi9mGchAydIkqn1I4ollSJEyyEL5lwcNOh8ORbS7
         QmNWczi2MC2HXxQamFDMS+d1YsTGF1hBiNRggOriXcHIYZxgJsVCG8dM5BSi6A6Pa9s5
         9mcBMJ2TYohc4+Os8yzZyjki74Av7Bn3wEucnOcK+3IeoAeUb0Yjr8g+HdSitl7GKfpI
         AFKIM/JgDKDMFqWyMl9hE5k/0Z+6L03EK017mud6L8Q9ugUW/CPKxMROkasur3lvoRhv
         bsAMTaxZqZTfKe00FWeuG2c6MaGbGppW8npUQtzzuETEPClcz82T6MM6UcIw5Rrmo7dv
         ypIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362319; x=1707967119;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIE1KqS+DFaPo+w+SIvDjHcTCcgNUuxxYztbzhygZA0=;
        b=s0DJ8Bvh0iWqDXsaUueawQJwlhUhv3fsmfHn8wTiEqK6F2MUHQPBsJAdoZJaf+340I
         QHC6n0UftDhROyuTiQM6HZ3SoiY46PmG6rm4USjYAl7nWiOv1yrNg11EcfHT08c2RIQl
         Uzd18pIC/1WgWYOWgYjh34vxOLh92v++Wsugzeh6dFTurpKI4Cn3p4cbpIlf0NHLNf3y
         qSOhaHB49r3PxVObqbwhX+riQYFJYjMhngZzgAe42IHbdTb/Bdujh+BBblJXt3kh7apB
         AvxN4IQp9BV0gPRpZs1XSwyXpOJgQrPcQnq6Oew+B+HIBS52uZ9Ez2kJqOJvSIT5mZoD
         rlTw==
X-Gm-Message-State: AOJu0YzUV2BxA61fXya2oTRhwLa5tAPP+aIrBjhlRoIcgTsdv7RScEdk
	xfVJWyQa5pEA1dP43Wzny50YVmBvR+xax8YuKHnknVlTjkIAHIpLuBOekZ/17w==
X-Google-Smtp-Source: AGHT+IFvne7Bagt1y/fBeaIYwsrRlH1roQNbxteUXkauL/JbBuOFzXm/opqXKtoBBsNWZEF2BDgS+w==
X-Received: by 2002:ac8:5c83:0:b0:42c:11a1:8fe4 with SMTP id r3-20020ac85c83000000b0042c11a18fe4mr8112819qta.3.1707362319505;
        Wed, 07 Feb 2024 19:18:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEUxIofwW74PGyoJ8FY1IJnu1uB/xuv29qq7GOkQQ3bLxYm6RvZoEXg7eMOUuEMPvUG5hgf/Z4umMIn2eFgTmQZn8yda4w1M8/17yTq6fnUACj2eYNw56eZEtcXkKZ2KfL1mvTqpMQIVqEzBLXWG+dRTYb+4C+jXEo2D5enqPxWWSl2r7nTeKLB76/JaB7COL/nbG9Mgt4xUPYeTZi3Fg3q8ZTTM7u1VU8+FqFwLIWiwk7mQp9lcmu5VTnmutOGLNLhzLqVR4jwJIimhBQ5jUW752kH/qa4/8piifOWpCIHcglw0kY2h1t/vHw27NOAgYmtoq6+uCacw2hwrZA9rNBzd1l3hdoz3TVcWC/fi6ZmVkOuEoxmMMChkikmvGIE/xBPSa11JP8nO8blMM4dwelWjXGk27aF7VAUC1eegwOaM2Q/WhnN/TZ+57QNdZceQlk2E94WzI4jJ+i8oPs8oAB4+BssO7wZhtT9VNOosqWWeEdP+jXQLQzZtJAooAZoTX0fN9/JKGxclSQDqlaYd/zA9aSU3T0TroTKAokjQE7G88Ru7REBI1ei/DVQzkGguzKGJbw7Y881w0hRSyFF85ZVkIovYPfLzc1ryq+CpoQHPdqZq5JsyNOyTla/EWZfMkScefkhtHeCEHBpEBP56q8ZzxFfU4+GFu/oVu5wuUG8EWyqvTiSw16BwDzNe8pXNnE+7L9qXrvNFijBuSdA00fTzhSZJR3eWHGn1BZm3mRyGiE71/GKzhvg9TuEDcZKZNBo4f+R9u9UPFDRlRPUp/9x9EXNER6kMYupk9+d/3bAAmBi+LPwnHXoeCuraN6jkzE5qzQpHIB89/lHNzf7xE34j7HF74znCHnsEZ/hgK/rvXFhvrACLk9XHJC6kVC0wHFuTos+lE+2UWtJiqGlTSk64WreLBTTtTa5ptAnIAkrIAzDWuffq7vNvEI7k7rsnI6DD
 49/ehc07WXbTQ=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ir8-20020a05622a6dc800b0042a6e6792basm1051838qtb.69.2024.02.07.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:39 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:38 -0500
Message-ID: <9f9fc3a959c74bbe51660656b632ba25@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 7/25] evm: Align evm_inode_setxattr() definition with  LSM infrastructure
References: <20240115181809.885385-8-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-8-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change evm_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/evm.h               | 4 ++--
>  security/integrity/evm/evm_main.c | 3 ++-
>  security/security.c               | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

