Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE080C7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjLKLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjLKLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:23:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC1AC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:23:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E8C433C8;
        Mon, 11 Dec 2023 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702293790;
        bh=RvXeZsCsTRB/ykFjhY8FOPGVRNC7qDb5nFcV0xvctXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS0qaeX8EfWKEh9IFSNTv9viV0+RH5CMAUNGSPtr0gzzUh3wQ1OQWEYPuGog/n7qa
         JG9vgFJieBvXCujm3q+AGF5r8aHBCkm8Ev14Zf9GpaVsm5ATjGJA7p0a6t3+RZgjjj
         zHbJiq93+6efh3/fgpfwAV8HtmmyJwsDuHmkQMkP89sohR/RpB2vS0WAyxSdCLgRkw
         BZ5Vf9/B4yqGg/VWi1U27vhwXs/xk2fU77XUQucztqh37e9OWdKr2hZIuQoKz+1Dpb
         hy9m9kaBsWbkDmwO+cca9g0ykwF5DHT+pqop0MjRzCuWWFB1q8g9VMhPhAM2HGky7y
         zoodfxRSjtLOQ==
Date:   Mon, 11 Dec 2023 13:23:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox
 version support
Message-ID: <20231211112305.GD4870@unreal>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
 <20231211084652.GC4870@unreal>
 <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 10:31:32AM +0000, Shinas Rasheed wrote:
> Hi Leon,
> 
> > > @@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct
> > octep_device *oct,  u32 vf_id,
> > >  {
> > >  	u32 vf_version = (u32)cmd.s_version.version;
> > >
> > > -	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> > > -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> > > +	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF
> > version:%d\n",
> > > +		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
> > > +	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
> > > +		rsp->s_version.version = vf_version;
> > >  	else
> > > -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> > > +		rsp->s_version.version =
> > OCTEP_PFVF_MBOX_VERSION_CURRENT;
> > > +
> > > +	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
> > > +	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
> > > +		vf_id, oct->vf_info[vf_id].mbox_version);
> > > +
> > > +	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> > >  }
> > 
> > <...>
> > 
> > > +#define OCTEP_PFVF_MBOX_VERSION_CURRENT
> > 	OCTEP_PFVF_MBOX_VERSION_V1
> > 
> > This architecture design is unlikely to work in the real world unless
> > you control both PF and VF environment. Mostly PF is running some old
> > legacy distribution while VFs run more modern OS and this check will
> > prevent to run new driver in VF.
> > 
> > Thanks
> 
> Thanks for the review. This version validation only concerns regarding the control net API layer (which is used to communicate with
> the firmware). In the case you have described, this instead enables new VF drivers to atleast work atop legacy PF drivers (note legacy here still
> refers to PF drivers which support this backward compatibility), although they might not be able to use the latest control net functionalities that they
> have been enabled for.

The question what will be in X years from now, when you will have v100?
Will you fallback to v0 for backward compatibility? 

> 
> In the absence of such a backward compatibility, VF drivers would issue control net requests which PF drivers wouldn't know, only leading to logs of
> incompatibility errors and erroneous usage. 
> 
> Also again please note that this version compatibility only concerns the control net infrastructure and API (the control plane).

It doesn't matter, even in best scenario, you can't guarantee that code in VM actually
implements version Y fully and will need to check correctness per-command anyway.

Thanks

> 
