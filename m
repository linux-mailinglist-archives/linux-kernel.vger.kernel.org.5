Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A747C8849
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjJMPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjJMPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5F95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697209456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fanr2UVL+2nniIjAFaTEYZESUnPsIrFphLfF6ehOj0I=;
        b=Dc47Ji2TW/9B0Z85fRWwxjD+7BiNamd5ATtazWp1ho7t3VkHXfBxW4k7C+4JEjWkhnYjq0
        xXjFeAndPxeu6ZfDHeyiVPlRljTDh7tOHOKtdBDODv790Zp8GpZvk7vXfPXKKhCa9lHB0M
        twchm5wMKLyodiCeEm3VZgy44rA1pR8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-wTEUg9VsMmyz5s1vR_i8Vg-1; Fri, 13 Oct 2023 11:04:03 -0400
X-MC-Unique: wTEUg9VsMmyz5s1vR_i8Vg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66216e7385fso22163946d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209443; x=1697814243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fanr2UVL+2nniIjAFaTEYZESUnPsIrFphLfF6ehOj0I=;
        b=KAu7dMOnP6vEqAzCc6/N4Pj3jYGsypfC6CHxoLOZfWImeqHmRbZWpV4oGvHYqffiaG
         k2JItpoT32D7LwW1dJ7V6HuJGGwUWCNG4ln0hFo+ab4aC80GMkxhQN241hrFeChGRyca
         HdbhUr2eX7fHdbenP/6YrxdlPSan/A461tWrClwzQgEm5/+BlHy3z8TDL5vwIpyH/ATw
         Z8kbmiSz1KcQ0N1estbhjahhW6koCcJGH+wwSRO/WKOl5n/UBdhbhZKPtvPjqKHFw+zL
         KPf1sf6KPuLWZblT5EiJZy/xgplp/2eyetAztll3fzOtNG1Xv8RFkhEQGvBEqPwXnUU2
         vNMg==
X-Gm-Message-State: AOJu0YwFn4lox8vDD0PG8JyRfQITNEh8P1ZTV1Kui7TE5JOXZJY4LZx2
        bkv9zy+Rw636fZOeCO6R69WB6i+scr2Rs2jDCYo5YMOmycdhZp3SwEjeDRpiJGtzg0g8fHFsWOp
        zAgvtoEb+QLYTuciGAB+uonwf
X-Received: by 2002:a0c:ea2c:0:b0:656:51b9:990e with SMTP id t12-20020a0cea2c000000b0065651b9990emr26082255qvp.57.1697209443233;
        Fri, 13 Oct 2023 08:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrk96WeM7PEfTiXqFn+XI1KMhVsRiXg6a34mYtKQ92DjlhZ/wrrzpdhvKPOXfvZbnSnt+L+w==
X-Received: by 2002:a0c:ea2c:0:b0:656:51b9:990e with SMTP id t12-20020a0cea2c000000b0065651b9990emr26082228qvp.57.1697209442773;
        Fri, 13 Oct 2023 08:04:02 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id a24-20020a0ca998000000b006616fbcc077sm732483qvb.129.2023.10.13.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:04:02 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:04:00 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 12/15] firmware: qcom: scm: add support for SHM bridge
 operations
Message-ID: <jcsd2xrj44ekh34ptl3gluzyikjqlauje7qdfohinju73twui7@fuglljx55uz7>
References: <20231013114843.63205-1-brgl@bgdev.pl>
 <20231013114843.63205-13-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013114843.63205-13-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:48:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add low-level primitives for enabling SHM bridge support as well as
> creating and destroying SHM bridge pools to qcom-scm.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Code wise this looks good to me, firmware interface wise I can't
properly review, so:

Acked-by: Andrew Halaney <ahalaney@redhat.com>

