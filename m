Return-Path: <linux-kernel+bounces-112204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AD8876E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6C1F237D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F11A38D6;
	Sat, 23 Mar 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciBQ/yJf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF75372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164798; cv=none; b=fneeqIhYAE9aFZUWzFZp2NA0z6Fx5jaVAydCn4Z5T1sIJ4zcIFFkSJ7mHf5seCy9uzGGoJUxYIsXcWyDPUVmwY9rJKNkVHLlqFYexyQrNIKPzQRbZZZ4znN4UutFrM7Ioz6Gtaew467GjMJse4eTYFLLypEHk00+yqab2AdbcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164798; c=relaxed/simple;
	bh=o0dsEEk8hdXMFEpldnIJ+u+SYXduDmm27PMGTXy78Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J/EraeptI0vxsDgauoQ74sDudQfP90p1oqQN5A/KAagBfsc1BKa2xvqgjTTeGrMXkjNOWsVNYldMV6zuto+tIFfmxhaf9yWBwESgZp/aSCxVjuAr79f81arkYHoA1jKU2v9y22/UJaVnl+WfmaM8bc61pZZF+Nl8qW26lxfWrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciBQ/yJf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711164795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l6VEXpPhpRKsRhcFDszqayWLNR7CuTmQSuGfDklNkUQ=;
	b=ciBQ/yJfXFrGyIktjjakhAJfDVOR/RLPNoYCP0qN5neigDUdzAUFLIUB0Kf1JefYIFbt38
	Uzg6FU9Jb9vnbLsOZpuwZES6YzyoLpx5j6q84pD3KGu8y9w1lZTuFe+nUnnEuqdej4MFKe
	73PHtKQ8gRlGNLGUTyRjKRogUzhi05M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-P6QdvPkmMkWDsmuJWhdhzw-1; Fri, 22 Mar 2024 23:33:13 -0400
X-MC-Unique: P6QdvPkmMkWDsmuJWhdhzw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430d45c66acso4827451cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711164793; x=1711769593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6VEXpPhpRKsRhcFDszqayWLNR7CuTmQSuGfDklNkUQ=;
        b=WeR97/3MkbJsURLKKx0op5YqBym7kTIcDf4vPZwfCimAVCvt1rOKEDOlUzz/v+XH30
         St+nlANl0vg4d/n6qyxjKq5I3kaaBCgy3l3MKKfcrRXgb492uRR57JBJDhBfpukZ1orE
         2RcArUlmgmcOgG2k258Yo9e02/PEZFFHtx3SWE0pJKOFXsPfJ2x/MQaHHHcN8n/auJuU
         DDLhkR6BTZih7eFFtceczodbT42T/UDogBLI7p2HXkCDFTiA/twKbgCc+pDz8XZf7i7w
         jra95+cEPm/3vum5hQF13gT129Wf8d7/eV/BsTYfkK92iDo25+Du9o6kr2xVaptOSa/o
         PzqQ==
X-Gm-Message-State: AOJu0YwszaLfS/uXplpdIEB/+e3kQFNAITyKgEkcq/EFisbV6glLkIBz
	u03iq5A+Lt5i7fNGued9lAmEW4hbbh8I4BAkcn9k7tk+7wVWPBxAKwuIKtEJ6xk1LiFoRuAQlDe
	r14v4fVNtEZBacNPHWM8Tp47y74joTByrNEKa8XdkJlvE+Pie6MVrxfQnjl6c2++Rh59XdIUTIY
	StGHgxRQLoXR4fwCCQawBVoohLM8rID/3ZfkvRk8DDcTI=
X-Received: by 2002:a05:622a:181b:b0:42e:f5bd:da4d with SMTP id t27-20020a05622a181b00b0042ef5bdda4dmr1441252qtc.5.1711164792883;
        Fri, 22 Mar 2024 20:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVK1Q7cMffsajBYbwQif4ui+0Hnsk2eSVPzTbX1jTdCjU1VGRBa8DtYZxRDDkdC/dNOnG9Hw==
X-Received: by 2002:a05:622a:181b:b0:42e:f5bd:da4d with SMTP id t27-20020a05622a181b00b0042ef5bdda4dmr1441230qtc.5.1711164792252;
        Fri, 22 Mar 2024 20:33:12 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j12-20020a05621419cc00b006910e7edfedsm1698198qvc.62.2024.03.22.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 20:33:11 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	peterx@redhat.com
Subject: [PATCH 0/2] mm: small fixup series for mm-unstable
Date: Fri, 22 Mar 2024 23:33:08 -0400
Message-ID: <20240323033310.971447-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Andrew,

This is the small series that should fixes the two reported issues on
mm-unstable for this series:

https://lore.kernel.org/r/20240321220802.679544-1-peterx@redhat.com

This is build tested on (1) x86_64, allnoconfig+allmodconfig, (2) m68k,
allnoconfig+allmodconfig.

Please consider dropping below quickfix:

  mm-gup-handle-hugepd-for-follow_page-fix

Then apply these two fixups.

Sorry this "small" fixup series is not that small.  Said that, I tested
apply and the fixup should auto-squash all fine on current mm-unstable with
a rebase.  If not, feel free to let me know if you want me to resend the
whole series with a base commit, or whatever easy for you.

Thanks,

Peter Xu (2):
  fixup! mm: make HPAGE_PXD_* macros even if !THP
  fixup! mm/gup: handle hugepd for follow_page()

 include/linux/huge_mm.h |  16 ++-
 mm/gup.c                | 287 ++++++++++++++++++++--------------------
 2 files changed, 154 insertions(+), 149 deletions(-)

-- 
2.44.0


