Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39F7808B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443439AbjLGOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443440AbjLGOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BF1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701960628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z40f2Fj9Y4MJPtpLN8oop6sdLxqO9gAb+p2VS6poMvg=;
        b=a9mwNEUWP8tWD2dKlRhFpoFef6AkM8uYVNKLtJU31szh8Ud5uzLQQQBgQLJVeQ8orPhtEq
        OLGOAu1123NRsCNorB0j/xoDi7PIWDJz/uCY4Hi4aKlrrXuUMv+jjlRiVixBc8fNLaIDQZ
        JGIA7z5rdiEUoELh/hYrBZOs0/tU+N0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-3PB9Ug-8PjiG1w63ioOqNQ-1; Thu, 07 Dec 2023 09:50:27 -0500
X-MC-Unique: 3PB9Ug-8PjiG1w63ioOqNQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58ceea508bfso1011227eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960626; x=1702565426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z40f2Fj9Y4MJPtpLN8oop6sdLxqO9gAb+p2VS6poMvg=;
        b=XsEfBIaG3S3wDj4fV3sHdejRUrfOKfJyXirsdOtp86pm/anG0XEe0ejWLMDHnlzFbb
         NreXCftS3JwDesXDfGr+YOyIFDRLMA0uCZBuECdHkhWj9EwvPaXcTJbrxldziedR1plX
         GVooNl0sOuE3U4AGYejIaBzn2escNiPAhfmYSmf04+c3nx6xrAWxDax6+LcFu27T64FW
         sfSrmvK4fWLWrNgOo+679c1jPhZy6hBx2j/9iYcsXxAJph0AdbNrGXBQgbm8qlVUfU8N
         MdVZTx4z+NXupTp7r6wf0NT0w2ixYG2ewmaHN6BNCa/nu4Ww2Do5W+GmsJFndKNZhqbr
         zM5w==
X-Gm-Message-State: AOJu0YwnEmXRgahhCJyXE31Ld6uBE2GRKp4/DlESCvczImfrjzpEpEgO
        ZNVDUAQkYI+tYE7dI/vQo9kN2f1fBY57Wa7M0qS89cYd8e8Q1B75gIcy6VMsdrUvVCXRkm+6vtp
        oiibcHY897lci69qz/DsTinAV
X-Received: by 2002:a05:6358:938c:b0:16f:eb38:e930 with SMTP id h12-20020a056358938c00b0016feb38e930mr2901436rwb.13.1701960626281;
        Thu, 07 Dec 2023 06:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN6r3K4vxPrfCUgyW4H13rPHjCx4Kbxc3KQVv9VJAn/47jz87juDBKDdsYhKUTxdaPY9iGhA==
X-Received: by 2002:a05:6358:938c:b0:16f:eb38:e930 with SMTP id h12-20020a056358938c00b0016feb38e930mr2901423rwb.13.1701960625993;
        Thu, 07 Dec 2023 06:50:25 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id m16-20020ad44b70000000b0067a2b91f969sm540730qvx.117.2023.12.07.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:50:25 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:50:23 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: qcom: pmic_pdcharger_ulog: fix sparse warnings
Message-ID: <tavnoj3mt7ylwuqn6giyqimppxn4s6ig2b2uusu2dgd6knybkt@p6ljuiq7nkef>
References: <20231207-topic-sm8x50-upstream-fix-pdcharger-ulog-sparse-v1-1-43f75455a9e3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-topic-sm8x50-upstream-fix-pdcharger-ulog-sparse-v1-1-43f75455a9e3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Neil,

On Thu, Dec 07, 2023 at 09:31:54AM +0100, Neil Armstrong wrote:
> Fix sparse warning by comverting values to le32() as expected
> in the get_ulog_req_msg.hdr struct.
> 
> Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312060355.M0eJtq4X-lkp@intel.com/
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I already sent this change (among two other small issues I found) over
at:

    https://lore.kernel.org/linux-arm-msm/20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com/

Thanks,
Andrew

