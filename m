Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97917F172B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjKTPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjKTPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC093D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700493781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxbmrPGylWswXo8aLH4U/JNxik/OiDDURPN0WtCCdCc=;
        b=XX/j28qAnJX+ci4pJo96vLQPGJ91NVKOnnK9kKcwE3ZrLntj7fOKv7sGGfHwUlzLUkWEQz
        kkL5gVsL7LxXpLtollOIfsrwOdFU7XfFxFHL6h0jOzBgDLBkZSKiNVrXuvPPgLB7QPJSf8
        ANgKJi2eXVXf/OWo3U/NZFF0dp+3Raw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-Z2Hd4SFIPImN50TpJyJAFA-1; Mon, 20 Nov 2023 10:22:59 -0500
X-MC-Unique: Z2Hd4SFIPImN50TpJyJAFA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cb7c104ddso51226121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493776; x=1701098576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxbmrPGylWswXo8aLH4U/JNxik/OiDDURPN0WtCCdCc=;
        b=M5cF6abcvhG4mL1NCixiFFBaIkvvRvF2O5dIdcmZMjbi/1zyxP2rzzBUmYsU0ABcvW
         W8WSRTIDgHIz3F6NJY5WE5SvjfPKETJrR1iuEiLoCs/Wzkw0tByteRJaO6iCKO67sWvL
         RNoKsC/v4+mjHa+Pg629u3RdyWs2q6XPrj/UkWwaCI0ZT/vXU2J1ZmIRsbIhpEfhn9uU
         tIutcgh7b2R6rV2n1/9oP7wL8HsYFwZAR4ASSo6WxiagO22PiPrmRLUN67Chk2lm1yBX
         uWqAcbasXUB0IJAsgvLs4+bHWZ4IjHcAhRQeQ1FwZ2O0b0vnKzBxgMDuRmLDnl8jASju
         HJRw==
X-Gm-Message-State: AOJu0YzHLHSGKwMu+8FuCqEPHCR8BQWVrINKzJ+e65Atq8xW2CyZAG8n
        vPwxCR3osoIolq6cUneWD3hyXBL7pDV6B5n/DMTaNJMend2pOj8N+Iv9T5BBJWN3QslysRq+oUT
        JF2J2ZPjvJGyUd243RcSX+tP8
X-Received: by 2002:ac8:5b84:0:b0:41e:1cd3:2ae9 with SMTP id a4-20020ac85b84000000b0041e1cd32ae9mr8941106qta.64.1700493776787;
        Mon, 20 Nov 2023 07:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFywBJRydhvu1dXvc1nv2EDgslOpX/xHYvPFOD5M1Uz1taB2jzWvRwaRdsYzsY10DnCgAtv1A==
X-Received: by 2002:ac8:5b84:0:b0:41e:1cd3:2ae9 with SMTP id a4-20020ac85b84000000b0041e1cd32ae9mr8941086qta.64.1700493776436;
        Mon, 20 Nov 2023 07:22:56 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id jr44-20020a05622a802c00b0041519614354sm2730324qtb.7.2023.11.20.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:22:56 -0800 (PST)
Date:   Mon, 20 Nov 2023 09:22:54 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: dwc3: qcom: fix resource leaks on probe deferral
Message-ID: <74cswe5tivcctmnty3gfavzsxdvjz5m4rktyj5auzwvrndninm@dah4h2fdj3zv>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
 <041f239f-7b40-4681-8c6c-2268f9c2c684@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041f239f-7b40-4681-8c6c-2268f9c2c684@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 12:47:30AM +0100, Konrad Dybcio wrote:
> On 17.11.2023 18:36, Johan Hovold wrote:
> > When reviewing the recently submitted series which reworks the dwc3 qcom
> > glue implementation [1], I noticed that the driver's tear down handling
> > is currently broken, something which can lead to memory leaks and
> > potentially use-after-free issues on probe deferral and on driver
> > unbind.
> > 
> > Let's get this sorted before reworking driver.
> > 
> > Note that the last patch has only been compile tested as I don't have
> > access to a sdm845 device.
> > 
> > Johan
> I'll sound like a broken record, but:
> 
> is there anyone in the world that is actively benefiting from this failed
> experiment of using the ACPI tables that were shipped with these SoCs?
> 
> There are so so so many shortcomings associated with it due to how Windows
> drivers on these platforms know waaaay too much and largely use ACPI to
> "bind driver x" and I simply think it doesn't make sense to continue
> carrying this code forward given little use and no testing.
> 
> Konrad
> 

For what it is worth, I have agreed with your opinion on this every time
I've read it. I am not the target audience of the question, but I'll at
least give my personal (interpreted: uneducated? undesired?) opinion
that the ACPI support in here adds little value and extra burden.

Of course that topic is a bit independent of this series, but I'd be
curious if a patchset removing the support would be welcomed or not by
maintainers, so I'm stirring the pot by replying here :)

Thanks,
Andrew

