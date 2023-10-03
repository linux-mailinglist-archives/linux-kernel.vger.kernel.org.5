Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990C7B6F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJCRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:23:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412FC95
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:23:42 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a22eaafd72so14617537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353821; x=1696958621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwE1HZmjz34Oqh172wfago5kgLVgz1X97TEm6Ersq1E=;
        b=k5HDd7TOy0Pvm6b+jkCTuRON5HQx8cAdsK5fkHPa2YF7wkyLWvpOvfC6tWxhwe8yhQ
         BUSU6Wo4ZntMyUd+Pg41qhJsu1SMiPkK3vmbXD1OIUz6DqJgUMDzm8K9LNMdqD9OYeDx
         zbMZneQBrqchSam67vEZlNLlPxdipFHzsqXxbKsCp/ex2CR680shS4jQVgIthcZJ42IP
         PikIJgqk4aKP08bKtdHTVwW26grMDAhJPS9cwFFj+iXlxi1iT3mM5r2TbMkRAvBK9K7T
         ljWRgHthToZ3EgUydUE/na8cpuS7NPfE0Cv0ZtCBFpkqnl4eYKyem2tteV6gMooIcQKe
         ZlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353821; x=1696958621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwE1HZmjz34Oqh172wfago5kgLVgz1X97TEm6Ersq1E=;
        b=GTdX3hbI9VTaHhPNAaPYjmv51Dpk2xyVSiMtrVESruyqgrkz9kgsp6lAqUoS3rOTeD
         XtRfywK6ZeMiWbmK8ZA9lQOp6hwJWeh26e0m05nhQesZHKzRk/PO5GjbiqVhRBAF3/Ut
         +YBIB63yLfYkQLF+Ij17BdRVpJyxRI5gk/EgT7pYuEj/WLp4pFnDVF1AZ4BsFBap8qxf
         CKdzM/aj58KHCX2BB5IzSlE2+9RgeFnSRnV9OfHNZ49KA9M1rEQVJEuEZ31NAUnTrte3
         k2Chdxf4DkyfvuqkRhd/42AXmrjVEW4/+vP6JpEMyl6nBRBZtJ10fgCtceV1H0Hk4TTc
         D37g==
X-Gm-Message-State: AOJu0YzbyWpevZ8YAjvtC5bSNeg1wGAtRAaX6/CqBeRC3Z9JVr6G7RF2
        tQ9Cmj7kOi2vemTJ5ujrGWEszTtWgiI=
X-Google-Smtp-Source: AGHT+IFx0XAmkUUQDLdw9s9udEu5Lv4R0yRhmk89DPnhEXF5lgAkdCr5HtOct5U8OekkEugwB2O2hg==
X-Received: by 2002:a0d:db0d:0:b0:59c:150:4155 with SMTP id d13-20020a0ddb0d000000b0059c01504155mr247757ywe.39.1696353821391;
        Tue, 03 Oct 2023 10:23:41 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.gmail.com with ESMTPSA id g5-20020a815205000000b0059b3d594c04sm520812ywb.125.2023.10.03.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:23:41 -0700 (PDT)
Date:   Tue, 3 Oct 2023 10:23:38 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 2/3] mm/rmap: convert page_move_anon_rmap() to
 folio_move_anon_rmap()
Message-ID: <ZRxOGqXRsKDZf4ik@unknowna0e70b2ca394.attlocal.net>
References: <20231002142949.235104-1-david@redhat.com>
 <20231002142949.235104-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002142949.235104-3-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:29:48PM +0200, David Hildenbrand wrote:
> Let's convert it to consume a folio.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

