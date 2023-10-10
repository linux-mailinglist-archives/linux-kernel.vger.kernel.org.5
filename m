Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E57C04E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJJTpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343595AbjJJTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B34B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696967083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZfQkL4IWwhQ8xY3yigkIDilLMVJu2obBuH4/ldBDck=;
        b=g3DfM5JLx+E5O5xmcGLOS4HxWZlHSZI52pV3fPzBQz+Jsuhu/H8OzfPVmqUpYYwXJt7s7m
        LwaMqQQjmmd//hzKWtyCVNXdJ4NaB4A+y1YP69Y++lNau0dMlhddYcEIhQhBXmYw9Lg7M1
        oXFL7tmtM3kyNzsaRKdZ6AOQhZQg8Qc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-iGpMK5B6MpGjfzNchbSm-w-1; Tue, 10 Oct 2023 15:44:36 -0400
X-MC-Unique: iGpMK5B6MpGjfzNchbSm-w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66ac99ce80eso72329016d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967076; x=1697571876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZfQkL4IWwhQ8xY3yigkIDilLMVJu2obBuH4/ldBDck=;
        b=Nrjw3JYvc0fJdkT3PxI/MZRm140CjAY6XpdoGtGy/MkF3xzNzcuOlIKE0AIgMhIBFj
         QLQG9/IKHSUPJn1QzCu2PzPM7ifSlmcO6wnm6y2GKKEb8PQOpmhZBAOo6W/1hEe3M9jI
         HDYE5rDEHeBHeGpep5c13S5W2BoaHH8BU8TaHDlTgl7XB/XKkiXk0V21jkbpF24Xda1t
         BSqc5c1yzcsVBQaux/mFxpVR04b5stxWOTgZTTxCmq6AaPtZB97FU9Xfocdm+G9xUsSF
         8w8aEBkHHxZyBaikQygI1cYgazwZA/AvPgdwSgewO+QN0ZATIL/6J/Xyi+eJuG8W+UHF
         tElQ==
X-Gm-Message-State: AOJu0Yyvn7JLWZOAHqy5SZJbOmUx0+G0sZA7pjDZWXfAO/ZuVXAtZxlX
        S/mhrTuoYKKtKrJD4JhPZPh2UpmFZy31lo0Vofl9odbQLfDRvzPoY1mjvX168h6E6wc7NlDtNVr
        5WCuYxhMtJf566DZF48QklQJb
X-Received: by 2002:a05:6214:451a:b0:65b:2b67:13c4 with SMTP id oo26-20020a056214451a00b0065b2b6713c4mr19366281qvb.61.1696967076351;
        Tue, 10 Oct 2023 12:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtVvyUJqsVfAztpy9YNYjWSO4sXIkpkPEA5qq+iNH3IdlP6z1BG6r1wxZvkbQYTlse5fZ81A==
X-Received: by 2002:a05:6214:451a:b0:65b:2b67:13c4 with SMTP id oo26-20020a056214451a00b0065b2b6713c4mr19366259qvb.61.1696967076072;
        Tue, 10 Oct 2023 12:44:36 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id u21-20020a0cb415000000b0065b0771f2edsm5078331qve.136.2023.10.10.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:44:35 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:44:33 -0500
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
Subject: Re: [PATCH v3 02/15] firmware: qcom: scm: add a missing forward
 declaration for struct device
Message-ID: <ldhnuua6jayqf4nflodpxoxz3u3t746c5egojnc4cw2uk744at@zrtaeeou7byv>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-3-brgl@bgdev.pl>
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

On Mon, Oct 09, 2023 at 05:34:14PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We reference struct device in the private scm header but we neither
> include linux/device.h nor forward declare it. Fix it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

