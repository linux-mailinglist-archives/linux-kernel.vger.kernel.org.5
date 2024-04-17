Return-Path: <linux-kernel+bounces-149298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF558A8F11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7E31F21502
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8F85297;
	Wed, 17 Apr 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZdFPFJq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119571734
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394942; cv=none; b=mKURjJvd5kHKQaM0VZ7tRsNF03g8wP5rFICabmYqvfJNLNPfkRJQD1ZYAt1r+6uBfeF/85f6CFQuAnFowkhe1brVnfpUJ+0fDHvv7hRIJylkdyCYYwzb1CZ+/CKnr3TQiPKkxLSeX6UKLmNg+4J0umexVp7O2e+P9S+g55476IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394942; c=relaxed/simple;
	bh=MjGEyWU6iRwQGLCvLbsauuSqXMR5IC0GgjI1b0nT/PA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwzPFO5IwZ+fRVcTtZdyO9RtfDgIuoYpnYpDy9Gbem2QfLpmLtfeK1oDqqaZX5AidNm0e7oavk2AGQ3P3J5JpuXXcI2dktKbgSs9BD0z+cqINBLPfz3gZLSWZeUGtbLygk1UUH0easF9Ce9G02Y0Bwk0QaK1Pa902CXQc1Sk7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ZdFPFJq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso474156276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713394940; x=1713999740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5We5W+rsfzPdvXFTCnohAUBKzbHH6tan/Fy+crluqZA=;
        b=0ZdFPFJqlBL0VRUml2c3qUsAt9V6MhLzw8pN6j5zQaOrXMGbrX4aM2oqQqlE5jpg2G
         xSASIIqJLah1q6VUUsgImyV7kcxQLEQfM1XS1G3Ks9OtwiJilMloPJIw4wz9WPnpKOHE
         VL2G3y7yTWEGOJKpZkgePEv+4QKb5Z57d669a397Nw8dIgnbT103lLX8TUeCD6tw+re/
         DOCZ6zkxyaJQaRF4kVYrRuoeGv+8kJ4R5xPxmv1b/XOwb1HqdHUjTeFEcmfWAQVbjkYu
         yw0qf+IOfiu/hRNZWjWvDle+Wt0G3BTUz2TsWprjZmt/emWQYdkJ9tXirM+h+BWzwb/k
         RQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713394940; x=1713999740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5We5W+rsfzPdvXFTCnohAUBKzbHH6tan/Fy+crluqZA=;
        b=RnCYmPKEf368gMoWfR6P/UGdAubtajtkkUlBkbDU0qFKNYfhzmdabwEBjg8V2SKfGu
         Szcs9kj1HeIhQjws/A+tZwtAeQMiZPRWWqsNQxULg9EE88UkdjXN0bBkf/t3u66w9WRs
         kOdXbOUc8wLvejGyjMGmjoFRSAY6/wEzynDkRSlROCaCFItJ+M5bhxLDaguV5VbFbZXi
         mmKyVKEGYcLtZqn8d4GF+JO4okA7Duz5T8msXWBOQNnANZSPgfy5DOLY1LUpSrDGUTlR
         q9adAW+XHDo+wErs62KylV5WHwPIjX9vi2u/3Q3ACWPapA5kqqKYyDbvv7LTqB1EPg3W
         uahw==
X-Gm-Message-State: AOJu0Yz1oGrf1xhj7bIRltEdTapgZeUuhhGCmcBzivyYRsLW7MQl4lLo
	6cWzUi3+AY6cabOUO3ZKjh16r5LnlxwJTAE5ZI6HBozD/TbBgQbwHZXBa2AXqJghQbhhe0akWMp
	xcA==
X-Google-Smtp-Source: AGHT+IERzpfBosJp5941x37Yo9n4uDrw4qeM+u1IpyiGpJYuIIdVxD1NzoxJcFf/f2t5gypae1skW2hucLw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1007:b0:dcc:6065:2b3d with SMTP id
 w7-20020a056902100700b00dcc60652b3dmr221743ybt.8.1713394940536; Wed, 17 Apr
 2024 16:02:20 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:02:19 -0700
In-Reply-To: <20240416201935.3525739-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416201935.3525739-1-pbonzini@redhat.com> <20240416201935.3525739-9-pbonzini@redhat.com>
Message-ID: <ZiBU-3PlL4dp3nFP@google.com>
Subject: Re: [PATCH v2 08/10] KVM: x86/mmu: Pass around full 64-bit error code
 for KVM page faults
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.gao@intel.com, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Paolo Bonzini wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> In some cases the full 64-bit error code for the KVM page fault will be
> needed to determine things like whether or not a fault was for a private
> or shared guest page, so update related code to accept the full 64-bit
> value so it can be plumbed all the way through to where it is needed.
> 
> The use of lower_32_bits() moves from kvm_mmu_page_fault() to
> FNAME(page_fault), since walking is independent of the data in the
> upper bits of the error code.

Heh, I prefer my version, which is already in kvm/queue :-)

0a5df50a2d6b ("KVM: x86/mmu: Pass full 64-bit error code when handling page faults")

