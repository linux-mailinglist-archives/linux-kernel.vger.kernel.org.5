Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CF75C6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjGUMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGUMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:19:10 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB72106;
        Fri, 21 Jul 2023 05:19:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LA40An006962;
        Fri, 21 Jul 2023 14:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=8jf3Y+n/y+JfiDeu+j5xacMWa2oOy4dEQ2WKqHh0NrY=;
 b=LPPdpl84ZSWsStOJML+beJ5qOPONAuo9qa9c9qsAo5lxU9+bzhcbL2DOglK9E13x3u1x
 lkIC50rKiKIHgZGUShhMrJU3sWaJRwLtIIPqXg8JI0FyPw1Uh4ySFE0J5tVfX0DJTQH9
 dAIXAHQfz/OW43kFCy9hCDhN46oVCiCgUfOuxTVZzhK2WjSaNqhAGk8cIipOOBA86W/G
 QvU5Oy6sFWOOQStSCxuD98hYGiTP0Zufohppfe/PLZk9D/SNKfG8cW8kn6E8SUyrWi7g
 WFZYveIARFjXLzhgjkiYokQx+VSCr4pEFsOfbc2yXMNCn2XXM6t87Yhp1Ruk/mhZ50Bh /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ryqxjh0an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 14:19:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A87310002A;
        Fri, 21 Jul 2023 14:19:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F1BD22D17C;
        Fri, 21 Jul 2023 14:19:03 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 21 Jul
 2023 14:19:02 +0200
Date:   Fri, 21 Jul 2023 14:18:54 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] media: i2c: st_mipid02: cascade s_stream call to the
 source subdev
Message-ID: <20230721121854.GA1172642@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711123211.794838-1-alain.volmat@foss.st.com>
 <20230711123211.794838-2-alain.volmat@foss.st.com>
 <cd0a1ec0-5ab9-dc14-b1ca-c990b062b3c5@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd0a1ec0-5ab9-dc14-b1ca-c990b062b3c5@xs4all.nl>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_08,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Jul 19, 2023 at 12:26:37PM +0200, Hans Verkuil wrote:
> On 11/07/2023 14:32, Alain Volmat wrote:
> > Cascade the s_stream call to the source subdev whenever the bridge
> > streaming is enable / disabled.
> > 
> > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > ---
> >  drivers/media/i2c/st-mipid02.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> > index 906553a28676..703d2f06f552 100644
> > --- a/drivers/media/i2c/st-mipid02.c
> > +++ b/drivers/media/i2c/st-mipid02.c
> > @@ -547,6 +547,13 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
> >  	struct i2c_client *client = bridge->i2c_client;
> >  	int ret;
> >  
> > +	if (!bridge->s_subdev)
> > +		goto error;
> 
> I'm getting this compiler warning:
> 
> media-git/drivers/media/i2c/st-mipid02.c: In function 'mipid02_stream_disable':
> media-git/drivers/media/i2c/st-mipid02.c:568:12: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
>   568 |         if (ret)
>       |            ^
> media-git/drivers/media/i2c/st-mipid02.c:548:13: note: 'ret' was declared here
>   548 |         int ret;
>       |             ^~~
> 
> I'm dropping this series, waiting for a v2.

Indeed, this was a real issue.  I added KCFLAGS=-Wmaybe-uninitialized
in my build command line to spot thoses issues from now on.

v2 posted with the fix.

> 
> Regards,
> 
> 	Hans

Regards,
Alain
> 
> > +
> > +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
> > +	if (ret)
> > +		goto error;
> > +
> >  	/* Disable all lanes */
> >  	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
> >  	if (ret)
> > @@ -633,6 +640,10 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
> >  	if (ret)
> >  		goto error;
> >  
> > +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 1);
> > +	if (ret)
> > +		goto error;
> > +
> >  	return 0;
> >  
> >  error:
> 
