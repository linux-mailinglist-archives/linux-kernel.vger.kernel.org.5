Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76180DB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjLKTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbjLKTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86ECD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702324320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qq03Jo5f/IYnaWG7QuyK0Yjjv5PibXRKmzmjiucs3YU=;
        b=Sw5nZoung7xMhxj58XlQ5mccLYPLEvoxKtXSnnPT5e81JUsK5yJBfrzejm4095mwXK45Mj
        dwusmnldtKXiAgQSHpF9JtgiOcMCjftalbRI8x3m0AYDjyHrqMZx71xZgiHsmv0iYwN0G6
        CSZcn8jOJJ3KkIBJ2dHrNGifzUQgv7w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-qvE_oCZsOsCwM3PcvCPmJw-1; Mon, 11 Dec 2023 14:51:59 -0500
X-MC-Unique: qvE_oCZsOsCwM3PcvCPmJw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a940dcd1aso67481606d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324319; x=1702929119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq03Jo5f/IYnaWG7QuyK0Yjjv5PibXRKmzmjiucs3YU=;
        b=YynCgkDiaQur8ge5F3ZAYYCeL2Q7pSR60CS+JmE+H6HmrreMRSW9OIMDoBfmtXanjI
         V0Qp05Jzdf2GADXlfxrC1FSqSqvGmJTZ7x8Kt2zNAqnob9qSz0r9S5vcZ14ENjLMrVqb
         ZVZIF0xoTgDKximBpHK2t2Vt6nS0vNnaWSaICYDlhlcx7mjBD7rSVnv1mxTnn0mI8Eod
         npW5n1RgIZ3xdyzXDzfBMDJ/pB9vUp9cf0GG2Yu44wHz1C0gtp+kyslGFCwDZAgJqsX4
         XXAXGm70qF9ubAddPQEgigyCz0MiuHA2wgOJRkt2uX5qfVfzf8rkPM3nH5Is3PH0gO1R
         7xFQ==
X-Gm-Message-State: AOJu0YzNKgWAGyy+m1cFZ2mGTcz055rW8naRV/0/G2SX6iHMvcqVITFQ
        cHjOLxrIkpv0BGtAkHV6e/zqevzfUFWxyunNVV8WeEWKn2G3oF3cGHxRvuC2N6pE9qL33pyrj+Y
        13ZJNg6klhv2jZ6oui6PPYffW
X-Received: by 2002:ad4:59d0:0:b0:67a:a721:82e8 with SMTP id el16-20020ad459d0000000b0067aa72182e8mr5502193qvb.66.1702324318989;
        Mon, 11 Dec 2023 11:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4+eOMOzP47aZt+EFlhHkf0eUx1qMFM1Dbo85dg2KxXg+o2VYJKcQRK6XmQpPp0Imc+Fr/KA==
X-Received: by 2002:ad4:59d0:0:b0:67a:a721:82e8 with SMTP id el16-20020ad459d0000000b0067aa72182e8mr5502181qvb.66.1702324318771;
        Mon, 11 Dec 2023 11:51:58 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id bo14-20020a05621414ae00b0067aaa7483efsm3533358qvb.6.2023.12.11.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:51:58 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:51:56 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Dov Levenglick <dovl@codeaurora.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: Perform read back after writing reset
 bit
Message-ID: <oyjzluv5ldvurqzsqiwxnjtmpvvjavkdxvbetwctq7qentdjbh@r27gvlj62scq>
References: <20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com>
 <0d59681d-2d7d-4459-b79c-c5f41f20b7a5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d59681d-2d7d-4459-b79c-c5f41f20b7a5@acm.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:59:25AM -0800, Bart Van Assche wrote:
> 
> On 12/8/23 12:19, Andrew Halaney wrote:
> > The recommendation for ensuring this bit has taken effect on the
> > device is to perform a read back to force it to make it all the way
> > to the device. This is documented in device-io.rst  [... ]
> There are more mb()'s that need to be replaced, namely the mb() calls in
> ufshcd_system_restore() and ufshcd_init().

I'll poke at those in v2 (or in a separate series if this is scooped up
prior).

Thanks,
Andrew

