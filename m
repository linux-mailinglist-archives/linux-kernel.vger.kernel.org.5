Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2B7D38FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjJWOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B276CC;
        Mon, 23 Oct 2023 07:10:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEC1C433C7;
        Mon, 23 Oct 2023 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698070222;
        bh=6vH16FEOHa8dxD2HaGOACPP5M5V5znbbUY7rMFuXZLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdQ2PuhhNMziTwMmg9/EeEJ3CbPiBjLIEnb/EfnjqUDyGdLGJMzQGfW5HAysZK8yr
         b/O4JKgUxxpouvDOazGmsset5rHSdPkbWBhSv/AeP5pk1rUAODyPuoHo+ocEACbrt5
         mNLvf41900/nYdAmDUHsd6DLiB8tPuLfsaJuwUW21dhlRYYcd6t3mBIXjVn3JnPVew
         wYmH4/oQVBUtZmeYX1ibALo+2N3bGZGWF4+2rXYsHX1GBNCR+86R83a5cQ3v7RdHbU
         LI0vRo8/147tvS9VM0tiZG3Ede/Uj7rMrVCtaNeRRuC9ePR27Pw3v62MruCHRCnLhn
         8h5lhhpniEdig==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quvdd-0000Z6-0W;
        Mon, 23 Oct 2023 16:10:37 +0200
Date:   Mon, 23 Oct 2023 16:10:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZTZ-3Vick1LBRKYb@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-4-quic_kriskura@quicinc.com>
 <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
 <257716c4-7194-4d26-a34c-fff09234628f@quicinc.com>
 <ZTY42KvYCk9HhCIE@hovoldconsulting.com>
 <e640c995-4751-464b-b6fc-106be822ae1c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e640c995-4751-464b-b6fc-106be822ae1c@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:03:32PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 2:41 PM, Johan Hovold wrote:
> 
> >>>> Multiport currently.
> >>>
> >>> You use capitalised "Multiport" in several places it seems. Is this an
> >>> established term for these controllers or should it just be "multiport"
> >>> or "multiple ports"?
> >>>
> >> This is an established term AFAIK. So I've been using it here like this.
> > 
> > Do you have a pointer? A google search seems to mostly come up with
> > links to this patch series.
> 
> Only pointer I had is the hardware programming guide internally. It 
> mentioned "Multiport" as an established term. I think that is self 
> explanatory in usb context. Isn't it ?

Self-explanatory, yes, just not sure whether capitalising it as
"Multiport" is warranted. But thanks for clarifying where this comes
from.

Johan
