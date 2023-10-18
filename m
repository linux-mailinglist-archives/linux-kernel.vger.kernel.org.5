Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F987CE030
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJROiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJROiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:38:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E615D42
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:37:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b79f96718eso2483643a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697639849; x=1698244649; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SL7tSXTgD7a36cyZqLF7jPyvczlnsdi7TzX18s08dI=;
        b=bkMLYCvldOMfQq0gr2MB5uQI8JLbbnArCRVPDkza/fkNpEvObkNoA7+1/UbAzBN1dh
         t37x1ZtQx6M8+k0VNPqe4OBuicD3L1Jqsa/6hlJDhFilivhsd9z7E36cNFlJjwdU3Hso
         CWDL41gZqlbao4xTFDVPBujIiJALupbC8PnesoBuRy3HuqmNm1B21Z9+35oaXI+pT37H
         BrEQcj1bUiSEC/J0MWxMJ8fwBn/ROf9G5c14+3G1BCmMN/q3YxLlmOCBASl6qGK0aOry
         oOLLSq2QCll9h0K9g5pYZmoC2x5SyFczR+TywYuCfgyhJxV61Jnv1RnO+l9PGiPLUdty
         INLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639849; x=1698244649;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SL7tSXTgD7a36cyZqLF7jPyvczlnsdi7TzX18s08dI=;
        b=HPGEYx+YnjFg/CBrX6FTz/oGLly7I7CuYznkf1Fd/hD9d62i8L78MSbHXwiCTWvg+d
         m6nn9rTMJqoevwHJAs/OodgUF90bW7AxLCbG/Z0MphVRigF/WA6q0FwEK3K1+sUGc8lZ
         VDuXD0WR+pAvp3WROC5whd7e0/YfGjrxaHzzMY/e0LF6ihqJB2YDIV7hT+WLsVraurwQ
         MgfK0lSML/hrPaDAeUEMAK6r+fjhC1JRy/ct8wjAFRW72ZUCsV0+15WIV/V+PIekWceg
         +NrHyRXtNaspBbbsxwnf7dkhf7y1FxJ1J+Tp+cdqtKpON/8lvmYEr6nVTT3fs71C1EAc
         7ytg==
X-Gm-Message-State: AOJu0YzOQjDhWWCgv2jTvgcmphasYRXn9D88g4UiPPHLUeEPb8rQE+oK
        FtBWh4coDQmebVmSQLqcC/x8IGYKP9A=
X-Google-Smtp-Source: AGHT+IFIXte9n3fhQv1LnsDFWs25090yeCopgomLtr+MaQMGFURHCGecSBjdlYY3bignAXkVKWFwK01WfNc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2641:0:b0:577:772a:a9b1 with SMTP id
 m62-20020a632641000000b00577772aa9b1mr119654pgm.4.1697639848976; Wed, 18 Oct
 2023 07:37:28 -0700 (PDT)
Date:   Wed, 18 Oct 2023 07:36:25 -0700
In-Reply-To: <20231012140715.2445237-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20231012140715.2445237-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <169763977372.1833121.15834410626925903393.b4-ty@google.com>
Subject: Re: [PATCH gmem FIXUP] selftests/kvm: guestmem: check fstat results
 on guestmem fd
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 10:07:15 -0400, Paolo Bonzini wrote:
> Do a basic sanity cheeck for the st_size and st_ino fields of
> a guestmem file descriptor.  The test would fail for example
> if guestmem.c used the innocuous-sounding function
> anon_inode_getfile() instead of the correct one,
> anon_inode_getfile_secure().
> 
> 
> [...]

Applied to kvm-x86 guest_memfd, thanks!

[1/1] selftests/kvm: guestmem: check fstat results on guestmem fd
      https://github.com/kvm-x86/linux/commit/911b515af3ec

--
https://github.com/kvm-x86/linux/tree/next
