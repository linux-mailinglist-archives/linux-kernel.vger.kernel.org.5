Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B37FDAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjK2O7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjK2O7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C9A19A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701269950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
        b=jCoAhfm/JcxyGA4jvYRzFOgJyutvZi2q343EBlSB36uOLxBeW8cAm0TrD2n+Z3bp0/nyvT
        +ZKAkWYXBoF8D5jEZQqdS1QAmc7OrYyFxptsrxtnfncLF5Hws0TGO/pJuF3il8E1nJLho9
        kO7J0SWJZhrC6LQJRJLByZSRkVjmk6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-HW4XZyE0OwG0RuBkVp_IhQ-1; Wed, 29 Nov 2023 09:59:09 -0500
X-MC-Unique: HW4XZyE0OwG0RuBkVp_IhQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333019151b2so2330283f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269948; x=1701874748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
        b=d20/yNjZO3VhN16YdosZx8hDqA1PTMabnMg64GDr6Lv0sVsn6He8RPbDj2cpSp8yX2
         Rn7DIKvshPTnYiImBhksCSkfyUJtXae6DmVZZ8aKp1aMTZOkxjrIA7CwDHKvQsBFz+K5
         m4nnnhS6fTdGXdTd2NktIIqj0Bc2zGXqyx6iR3bTGBE9XCpCwqwCP4e1pkS6ry5ZvMEo
         eYSmCVxIW2qTX7GDgdVJ4si2VHrp9EKhQ3zC7wcz+iJEpL488xxy5n4v1QPCyI1VZAyD
         rBG+PSMqQC/AgHZP+9w1ysv6Q8s23zEHfBp7/ihn1UOwCygHc2ytJhUZkEVSLd2UA6hS
         ds6Q==
X-Gm-Message-State: AOJu0YyMDHzlwOnPyFfuhAS735VP2AJ8N7SY+niWI9JRxbEOAlVUGYbb
        T87J9HxU2SjZjSIryj31FKkhR35PflfdDmnHxnOCvRGd7DGqeqZzcGl8ToZpBAhfwOwZfqJHq+z
        4sdN1MoNgQSC+aVZcz94mtZW62XqYePG/
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590105wrn.9.1701269948085;
        Wed, 29 Nov 2023 06:59:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmMigrMbu6mymybp1KFy8Po2HEeHonkXFHl9UM+Rm947CoT67bByrDPdYVKwxNSrc1C5AKsA==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590083wrn.9.1701269947721;
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b00332e7f9e2a8sm16187336wrd.68.2023.11.29.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Date:   Wed, 29 Nov 2023 09:59:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <20231129095825-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
> 在 2023/5/26 13:46, Liang Chen 写道:


what made you respond to a patch from May, now?

-- 
MST

