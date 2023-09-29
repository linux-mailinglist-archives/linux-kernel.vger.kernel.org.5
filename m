Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408A37B32FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjI2NAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjI2NAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F2A1B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695992401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkolkQYQP8wA78QWjAn3k7nmXFE7e3GBg0yVcUVtpGY=;
        b=Ut4STMkt5ezKKN/Zzch8H2QnJRN6vEBVYvu0Xwnup7aFTW9BnOkYJoChDXPbWP2PVrcj4H
        fdFHWjw7HL2gdPFjO3ILxxNBE7E01sCALLoVUpnUCiEa1rXWZVYCF+j8s0FUsWMqt9MjJG
        mzW4efvnZ+JSxciKs/Rfk926EfRGcO8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-pNZSFr-eOSawUe53BQzRSA-1; Fri, 29 Sep 2023 09:00:00 -0400
X-MC-Unique: pNZSFr-eOSawUe53BQzRSA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c45228f2b8so28904961a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992399; x=1696597199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkolkQYQP8wA78QWjAn3k7nmXFE7e3GBg0yVcUVtpGY=;
        b=RIGgE1RN9Ql65z2RwALJs/s1Hpl2jIxshcYBUSEu510AuNHqVOMgyEZcUVsX2vVAX0
         iKhQ5NXPh3QTyPPawoD/ahC8MFywt42hiJkKf2qjzg43nXWqtDjwm1ca5D3YRRTXz0FM
         Bdm9A2rBiJ7xDXk0KeNSVOQAz9p2P/6u2uhAHydmE1YDn5H0s1YYwoIrqCE1LdI8idV6
         yDHT/m+d1D7O6eb5kVSoJNLKnKcGeJI9R6UzbgwYTr5CCfvbKkfhU+s4CGlCbPjov7Z3
         WCdV0A8sjR3jZxYz/94UuGvWMpS+xj4Ch0RDbTeWUUDTSN9NWuJfYTWisREDTLJHgda4
         QRdA==
X-Gm-Message-State: AOJu0Yz051tOltow+ewqeQBNZUANj8wgoGhl27e1tNIZeYUd4y7gLv/m
        VT2UejpSYOjmGrECO/ekORnh6b6idpjoFNM05heKgVnewxO0oEwVOJcuTduhdLnkECZVHRvASs2
        5No/GqmMwDc3jhWiJyupj9ZrT
X-Received: by 2002:a9d:74d9:0:b0:6c4:897a:31d0 with SMTP id a25-20020a9d74d9000000b006c4897a31d0mr4253073otl.24.1695992399386;
        Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLY5DCnpt7G3mwAyMbr7IKILwUmspq5W5zRmjj7YDnrzd1R0IGknP2GqFr/Hqk98SQpW2BwA==
X-Received: by 2002:a9d:74d9:0:b0:6c4:897a:31d0 with SMTP id a25-20020a9d74d9000000b006c4897a31d0mr4253053otl.24.1695992399064;
        Fri, 29 Sep 2023 05:59:59 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::42])
        by smtp.gmail.com with ESMTPSA id d1-20020a9d5e01000000b006b90b5626desm2996566oti.62.2023.09.29.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:59:58 -0700 (PDT)
Date:   Fri, 29 Sep 2023 07:59:56 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix enable request
 endianness
Message-ID: <20230929125956.hpcze2brit3ew3et@halaney-x13s>
References: <20230929101649.20206-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929101649.20206-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:16:49PM +0200, Johan Hovold wrote:
> Add the missing endianness conversion when sending the enable request so
> that the driver will work also on a hypothetical big-endian machine.
> 
> This issue was reported by sparse.
> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

