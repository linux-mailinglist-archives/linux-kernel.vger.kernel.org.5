Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EB7C04E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjJJTqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343595AbjJJTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F6B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696967132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUuQl/nIQ+SkLo+mr8xfO0O0dG6CGuGsIcyWiV82E1c=;
        b=YTFYXc5LjsbZg3z+I8ET2Z0YE3sBoEmllracbZEUUZQR9vpVODcL5HGrICEd9LQvVDKMKc
        JgurqepNhNf/QJrUa58ku/tQhRD739URrxTcpJ2sNzbbok8F80gHgSHWfoCF8t1wRY/v+A
        IT9aOQq5t6Aw3XG9Rz/96IJdA2x+b98=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-AtqIlfzZPAKfXG0KJJz3hg-1; Tue, 10 Oct 2023 15:45:21 -0400
X-MC-Unique: AtqIlfzZPAKfXG0KJJz3hg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-49abefc54f4so2968563e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967120; x=1697571920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUuQl/nIQ+SkLo+mr8xfO0O0dG6CGuGsIcyWiV82E1c=;
        b=fOVDiqOF+uppAt8K8CzNb3qh27cd+2oM64FsP2aL3fONxkYPMb98DsDT0/9ugyIohA
         dLZjSfJRrUZyb7qR/kE/VRpz886L4qK4gMnC17PpWnQ0yze8FegCMAPfdC2l6owECjnM
         +S02D+diAX8AflGy3au3DLapIA7nE+fsFwAUsm9b22JNYUWvyANGfhZ0s8rNGTL9x2mA
         Y3OXKn4z6QLn6NPk1nYtaozrNN8v0v2sw35vkTgucIRaZOrpKUELFOD9gYDDih5U9E12
         fbr4hawYV5vkmB38mtBVAwYZgvy/A+MMNR0EFd8pj78rvACRsyGJyh9VIzhNwAzEslM7
         etag==
X-Gm-Message-State: AOJu0Yyvr1u3qnEvHUL5Zo80W0GqtxYX4s7X9SL1uje76NNrPHhDf+Zh
        nXxlCKhaxLFcilGeGkJN0GAUPbQjyTI9d/W70pbiDVm5P0ClvJccx2sFoyThgn+hwZq1PM+0jPJ
        sg9xqkzDYuUe/iIy0lFCJRUEk
X-Received: by 2002:a1f:c9c1:0:b0:49d:94a3:dd5 with SMTP id z184-20020a1fc9c1000000b0049d94a30dd5mr16360398vkf.9.1696967120501;
        Tue, 10 Oct 2023 12:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4A2kxEFXcO6bmqDcCgKQNe8y9jBtfbioJZyYMx71IMKn+3kAIQJSAuRQks5T3q6L8fgiQVQ==
X-Received: by 2002:a1f:c9c1:0:b0:49d:94a3:dd5 with SMTP id z184-20020a1fc9c1000000b0049d94a30dd5mr16360388vkf.9.1696967120259;
        Tue, 10 Oct 2023 12:45:20 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id b7-20020ac812c7000000b00417fa0cd77esm4737917qtj.80.2023.10.10.12.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:45:19 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:45:17 -0500
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
Subject: Re: [PATCH v3 03/15] firmware: qcom: scm: remove unneeded 'extern'
 specifiers
Message-ID: <guwypykdpixdlipfddam6uxrwbagp2dcjfnyecfvo7ykwqchm5@fkagjo7lmac3>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-4-brgl@bgdev.pl>
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

On Mon, Oct 09, 2023 at 05:34:15PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> 'extern' specifiers do nothing for function declarations. Remove them
> from the private qcom-scm header.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

