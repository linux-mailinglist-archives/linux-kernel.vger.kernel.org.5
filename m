Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4877C8837
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjJMPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D5BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697209324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rceeu0VCieDlV0IrlDkPVP2q5+HsG2v/f7CK5R/WNaw=;
        b=GNsK/NEuyoycWLwqDwp4JeKqxZxU32HiASdB0Wgd0F9hbY2i29uFR0Ke3wwj6J2bcEgXxw
        XVmVCzegsVETgXllKXrrUhmYvk/4aPbb/E5I3hDn8oeiQCLg1hu1FWSdFi3twS2fwPKHbl
        h/P2zGsfw8haO0/Y6yyMsm3YyOpbjPw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-XMv9ImAlP6CpTlDX6lhHNA-1; Fri, 13 Oct 2023 11:02:02 -0400
X-MC-Unique: XMv9ImAlP6CpTlDX6lhHNA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41977b9970dso22898421cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209322; x=1697814122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rceeu0VCieDlV0IrlDkPVP2q5+HsG2v/f7CK5R/WNaw=;
        b=Ey+gchEDUR21Hn2XlzpOGltRz4Y2qBWxX6XkctwP04ghofGen3+fnS+ddRpcCi8214
         5pIUu6oGRoIjqdTHvfWdx14D8URdBAU1l38++onE04//xxVYMwtPo/t3jaNuFsGDJ0Q4
         W2Jbh9YENBlfpZ65Hi46pnLoVRQ1xLPjgK+nYx1lOrQdioOPDbOPkoeILDeTT6xB/oVV
         RSmLsvcj+ne5p8q+jLrmgkvNp5tTPS+tqAjb+VHMIGhiYBRzXUAfnc5o19KI9YzjyLhL
         y/BBQAstWRH0iTm9rNeVHnFbBXPlbiGF/qnDmadksKQ7R3f0YunkqdnhvQ8bwu4sOemp
         6JTA==
X-Gm-Message-State: AOJu0YznU09OFxrdGS0cxM8rxhRZ3xFI0v2IcCMJrpsdvdXnkLvrl+90
        Z0/RCf8VI7IsyDLCfYdOI4vdvZpjvNMUU5ioe9K1lz8E/NYwps2ebTyZpd6mzoYdm4akcR2QkUz
        Jbyiw11SrsQCVOSaqglqW/FAp
X-Received: by 2002:a05:622a:44b:b0:418:17f3:ccc0 with SMTP id o11-20020a05622a044b00b0041817f3ccc0mr35404181qtx.56.1697209322041;
        Fri, 13 Oct 2023 08:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHphW6kyjwXlo3xruqsPlCBj7jdExaUjCwBOnEuMwiuamZQ5i1GxIHDed5LrCyxmOv6ime41g==
X-Received: by 2002:a05:622a:44b:b0:418:17f3:ccc0 with SMTP id o11-20020a05622a044b00b0041817f3ccc0mr35404135qtx.56.1697209321559;
        Fri, 13 Oct 2023 08:02:01 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id x26-20020ac84d5a000000b0041520676966sm664565qtv.47.2023.10.13.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:02:00 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:01:58 -0500
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
Subject: Re: [PATCH v4 05/15] firmware: qcom: scm: enable the TZ mem allocator
Message-ID: <4ojnfvx3upmklxteisp7rgymfnkksqkq3s6ewg3fma5ywyd7cd@zqdr6ovehphh>
References: <20231013114843.63205-1-brgl@bgdev.pl>
 <20231013114843.63205-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013114843.63205-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:48:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Select the TrustZone memory allocator in Kconfig and create a pool of
> memory shareable with the TrustZone when probing the SCM driver.
> 
> This will allow a gradual conversion of all relevant SCM calls to using
> the dedicated allocator.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

