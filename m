Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7414750FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGLRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:46:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76FE8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:46:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eec46206so6459920b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689183964; x=1691775964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pG+mh8+91Lqxt1AwYL13LCohu/84x786utKIEjcfvxI=;
        b=PcS3MqWhgV95HZbZ06H2dHpBcbNA4q8G8B6AsNEJX5e5tsZ4hDMCb/erYX8X19QQbL
         pplQCKNlvhh2dEUFUGem9dm42LUlwNyQFTHJ2BhCjJUuToVO2Bvpb5dU24+12jLuj4HB
         Mw2mnQG3V3+YA12vjm/lX24wvjVwawK0YWVq8KYJaCjzoarD/uv5AiLfFBs3Zp/PH+6e
         nggAzUZ8Xz3v79rLHuEAQyyoxtLCytzdyEGzcRYeIOC2GKWM9tz9CViT8cwMmJn06/0b
         mlnCyBMWdwe0wMXcgF5wcYDtbd404y5PZ1AzQ1zS5///pZsEdQyHxwAULNxiCeS5nPmW
         yQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183964; x=1691775964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG+mh8+91Lqxt1AwYL13LCohu/84x786utKIEjcfvxI=;
        b=UpBMKinfrSR7vMF1haH5m/bkWwPpfT4QNmQXXtjVEjGnMBIvYwrtJ01dQuHEAWuTs2
         ACoK9YfSWr/uZwfHPoDdDqEhMoFFNTf+aCkI6ropuz+pMHAPrubEOuiUvcR/+ez2dt4S
         YHycUP3b9dfJdL3dZBH0t/tUFrxCU/8XHqN07GxNR2wfC0T/e5zK34OH7AJFLh/Svj7R
         NDLHH31YBT13A3uL0H3CPlXfRtQItxu8cWGsaEm0Cc4QUJzbnmfPnU7vip7lc1jTyO8x
         33OrosC+3q+vpaaVRIcyH2p8/v2786qg2cPj25aI9Kr6OVKtV192KMhnjjrP72q/unKd
         6Xpg==
X-Gm-Message-State: ABy/qLZ+djA3KplbhNXoUNow8M5POv9olNIyd6fVc3y6g/fvwHIvdEAv
        YYyzkII6tRyLyMESB1R5RDsI9Q==
X-Google-Smtp-Source: APBJJlGN2tL4kUzxqQUF/g+hbiZKlLUKyYvng1AXAvMObjxpM9rf9nphVUO0DQIKawitkscQwlrYKg==
X-Received: by 2002:a05:6a20:1589:b0:12c:6268:cd31 with SMTP id h9-20020a056a20158900b0012c6268cd31mr23998436pzj.47.1689183963926;
        Wed, 12 Jul 2023 10:46:03 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id k11-20020aa790cb000000b00675701f456csm3884000pfk.54.2023.07.12.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:46:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 23:15:54 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZK7m0hjQg7H5rANZ@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
 <20230710170608.GA346178@rocinante>
 <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:52:23AM +0200, Johan Hovold wrote:
> On Tue, Jul 11, 2023 at 02:06:08AM +0900, Krzysztof Wilczyński wrote:
> 
> > > > > > > Finally, note that the intel-gw driver is the only driver currently not
> > > > > > > providing a start_link callback and instead starts the link in its
> > > > > > > host_init callback, and which may avoid an additional one-second timeout
> > > > > > > during probe by making the link-up wait conditional. If anyone cares,
> > > > > > > that can be done in a follow-up patch with a proper motivation.
> 
> > The whole conversation above about the intel-gw driver: would something
> > need to be addressed here?  Or can I pick the suggested fix?
> 
> No, it's just another indication that the offending commit was confused.
> 
> All mainline drivers already start the link before that
> wait-for-link-up, so the commit in question makes very little sense.
> That's why I prefer reverting it, so as to not pollute the git logs
> (e.g. for git blame) with misleading justifications.
Johan, Mani,
I am developing a PCIe driver which will not have the start_link
callback defined. Instead, the link will be coming up much later based
on some other trigger. So my driver will not attempt the LTSSM training
on probe. So even if the probe is made asynchronous, it will still end
up wasting 1 second of time.
> 
> > > > My apologies for adding this regression in some of the SOCs.
> > > > May I suggest to keep my patch and make the following change instead?
> > > > This shall keep the existing behavior as is, and save the boot time
> > > > for drivers that do not define the start_link()?
> > [...]
> > 
> > > I just realized that Fabio pushed exactly the same patch as I suggested
> > > here:
> > > https://lore.kernel.org/all/20230704122635.1362156-1-festevam@gmail.com/.
> > > I think it is better we take it instead of reverting my commit.
> > 
> > Will do.  I will also make sure that we have correct attributions in place.
> 
> As I mentioned in the commit message, I think the commit should just be
> reverted and if there's a valid argument to be made for a similar type
> of change (without the breakage), that can be done as a follow-up with a
> proper motivation.
> 
> Johan
I agree that my commit created regression in some of the existing SOCs.
I should not have taken the liberty to return an error if the
wait-for-link-up call fails in the probe.
But my commit's message body clearly mentions the motivation behind
calling dw_pcie_wait_for_link() only if the start_link is defined. Can
you please re-evaluate the decision to revert my patch and pick up the
suggested fix instead?

Thanks
Ajay
