Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A507F97F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0Dlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0Dlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:41:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56965122
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:41:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c1acc1fa98so3355891a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701056515; x=1701661315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=658rtDCoA3Do8XbxgxnIPu7n7tXNaahQrbL0g80hn0o=;
        b=BHCnBqrLRMrvG75zCAqXbE/c2yP3NrM7VIEntIMtlnD8zAWU/VyZCWT4AhwUUtFqCg
         OCGdq0e2MNTX1q3TG5ePNHK4Pdw4xm2BRnC2xT1L6dRp+Tma9eDZl8KIMHXn3bnGkcWL
         X6EO3Nf0y7cKocy9+6eQKqq+uN8x2BhVNwUXE6lSSehL1dttCnfgv2ztVvbf2WnAy6ui
         bewr5QtN+4uFcB+FR7phUoRToZYEW0352ySSv4knBcqvIKok2iVAak7bymtjWuoYghrY
         6G7DapEz1GrB8Q2CjTfepIpdqVlLeGHWleA1fymvyuxYz1n9mczeL2Ka67e1Y5SDtSVL
         tcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701056515; x=1701661315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=658rtDCoA3Do8XbxgxnIPu7n7tXNaahQrbL0g80hn0o=;
        b=qRzqeEV1l6VtKiWFAeK90UE4NlSz8k0deb7Um+3tJDVzemdV3gPEgeKu49zYs3AJiX
         N9Rn1CyqJenW73OLYi7R94rqGPHOKVOGPP8aOgplO0x9Yi304SyCpGwtBxx5PjiaIDgJ
         HNLfS3b+objTTVZtVRdQE2VTzMcligcd8F+9l8JZXMfJIIj6WsfksGzpuaPC3ZL7NST6
         z96+/yJ0J8ddZQe79GZr9Xerir+s8u/DcB4ktczrF2JmXx67MfMIgtVYblaf6f+qYx+Y
         1BwtDNYtsMGHKeY20Evlwv9KqDKl6IXfvV/iGJsTjvWA5MFVdC/vk4wj69FtyoqoH3qU
         tlmg==
X-Gm-Message-State: AOJu0Yx4v+ZYDavJ+Nxfg94WUk1bUb22JlhOViVkFARRrSJTotQbexRQ
        Dp05G3G4UTfywf5u5Xfnfzo=
X-Google-Smtp-Source: AGHT+IGH9WUVSSl8ZYb/w0N9CSAE81DXs9wZCWMAsYD80P/5yxaKL3tsvPGkb6jZRPI830tTmT/OTg==
X-Received: by 2002:a17:90b:118:b0:277:68c3:64b9 with SMTP id p24-20020a17090b011800b0027768c364b9mr18749555pjz.5.1701056514711;
        Sun, 26 Nov 2023 19:41:54 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a061:a5bd:f09d:c339])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a035900b002775281b9easm7237424pjf.50.2023.11.26.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 19:41:54 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, david@redhat.com, fengwei.yin@intel.com,
        hughd@google.com, itaru.kitayama@gmail.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, rientjes@google.com,
        shy828301@gmail.com, vbabka@suse.cz, wangkefeng.wang@huawei.com,
        willy@infradead.org, ying.huang@intel.com, yuzhao@google.com,
        ziy@nvidia.com
Subject: Re: [RESEND PATCH v7 04/10] mm: thp: Support allocation of anonymous small-sized THP
Date:   Mon, 27 Nov 2023 16:41:35 +1300
Message-Id: <20231127034135.6754-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122162950.3854897-5-ryan.roberts@arm.com>
References: <20231122162950.3854897-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
> +	    (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>  		goto release;
>  	}

Hi Ryan,
what has stopped nr_pages == 1 from using !pte_range_none(vmf->pte, 1)
directly, then the code can become,
+	if (!pte_range_none(vmf->pte, nr_pages)) {
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
 		goto release;
 	}

for both 1 and > 1 cases?

Thanks
Barry

