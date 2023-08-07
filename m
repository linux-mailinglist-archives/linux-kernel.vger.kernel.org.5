Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789FF772E91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHGTTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA710E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691435935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBw4mbV0n5CHJTT93sh7px+x2h6v80hNyKF0sUR1CQ0=;
        b=MrV/fd3rdsEJIV3hzfYA+OlIjm1XsGQCos5znwWGMHblF9wSmTovxX/CPrIRHArLs7BWNp
        9FDK/8fmRbnbekXtDgeWGnmOMYCPBLnsMkj0aXvEOupGbapaNgmf2XZY/fxJj9Mv9Kdajh
        HKP8G6CWPTcvwvqQdQpud6sT2z7KOPo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-3WWEB-hMMhuloz80Rbwsvg-1; Mon, 07 Aug 2023 15:18:53 -0400
X-MC-Unique: 3WWEB-hMMhuloz80Rbwsvg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5eee6742285so59420656d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691435933; x=1692040733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBw4mbV0n5CHJTT93sh7px+x2h6v80hNyKF0sUR1CQ0=;
        b=RZ3X0qT3IIJ0DbhyUx/hYWMTABr9VmJc+H5G+ENNoXU9G0hk1vSEDyFJ9BNJXAlEbs
         pl7SvFQK7+6frxkG0/vDWAymtSrbm0Dqx+xmK4DK/ieAoqTaAwxtxLZoZ+A0mau/VqB5
         7xtEInrwF8NwnAU5Z+soeQ5UYzSAve6hug0HXyzvIA9XAMsPpgC2HaQzBgtPetGD9+8d
         mBsC+HvFnmCoglz2vqcWV3I+nSMO8RgHmoF4g+wCxSjPc8LpBtxHdMS25w/CX2psBa6W
         ecNOPdVVMzLUNY9MzrQoAQzhAjq/44q604dox7dBwWBxepEV+GTU8NaTKCNCVsrPjlCH
         Fr2g==
X-Gm-Message-State: AOJu0Yw3Lalb5fbJm1VyoEqRPthQHuuvRCxhIUp6VZocHfl4SjyOpzU+
        3ke+coRGC6xO5X3/1TaWrtPX0/zWvC6Fg+0FJzS6c34hmBwHYNzsnsKsuT0Xjmiq2KDNbvH+ZDp
        Q9XDLdXjDGPBDijOTgsVhL9bG
X-Received: by 2002:a0c:e0cc:0:b0:633:45e2:5603 with SMTP id x12-20020a0ce0cc000000b0063345e25603mr9893925qvk.60.1691435933472;
        Mon, 07 Aug 2023 12:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf08IuAF1M+sWXoajzIojAHG+tZ0mzMymTkRHCnxLwdLNIOx7LjEpAHQQPbeGpQrMmO5ygPQ==
X-Received: by 2002:a0c:e0cc:0:b0:633:45e2:5603 with SMTP id x12-20020a0ce0cc000000b0063345e25603mr9893910qvk.60.1691435933263;
        Mon, 07 Aug 2023 12:18:53 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id b12-20020a0cf04c000000b00631f02c2279sm3069007qvl.90.2023.08.07.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:18:52 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:18:50 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jlelli@redhat.com,
        vschneid@redhat.com, pauld@redhat.com, rt-maint@redhat.com
Subject: Re: [preempt-rt] BUG: sleeping function called from invalid context
 at drivers/gpu/drm/i915/gt/uc/intel_guc.h
Message-ID: <ZNFDmq43NqttzJca@thinkpad2021>
References: <ZKyngsXKztAU9J3r@thinkpad2021>
 <20230807133354.-t5iv19T@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807133354.-t5iv19T@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:33:54PM +0200, Sebastian Andrzej Siewior wrote:
> 
> Could you try v6.4.6-rt8+ and check if it still there or gone?
> 
> Sebastian
>

Just checked. I do not see the call traces in dmesg now.

This also resolves a long (20+ minute) boot issue I had + stuttering in
the graphical interface.

Thank you for asking about that Sebastian.

John

