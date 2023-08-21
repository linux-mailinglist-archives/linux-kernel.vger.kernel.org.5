Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FD7824F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjHUHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjHUHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:55:32 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27840B1;
        Mon, 21 Aug 2023 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692604531; x=1724140531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WarJnYSIIDCoK08Blaeh9upNnOdNiIg5pqTIPcpbuWA=;
  b=RCudqmiK2HRxPtCNSvs1FVe+gYbJxtPOMrlEzFBd80e6uOO/SRf0pn5x
   X5d0sPMs6hRLzkagtQAnZHNgct4pv1I43/vo1CNIl+33+3pILcFoe26bi
   jGkIo4BYn4SnTCmKSo9UHS/Uk6ZibleOnvk4pVwzCdJld+V2i954LUhiW
   I=;
X-IronPort-AV: E=Sophos;i="6.01,189,1684800000"; 
   d="scan'208";a="23717432"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 07:55:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id F02B860E80;
        Mon, 21 Aug 2023 07:55:29 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 07:55:29 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.142.138.205) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 21 Aug 2023 07:55:29 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <casey@schaufler-ca.com>
CC:     <jmorris@namei.org>, <kamatam@amazon.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>, <mengcc@amazon.com>,
        <miklos@szeredi.hu>, <paul@paul-moore.com>,
        <roberto.sassu@huawei.com>, <roberto.sassu@huaweicloud.com>,
        <serge@hallyn.com>, <yoonjaeh@amazon.com>, <zohar@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/2] smack: Retrieve transmuting information in smack_inode_getsecurity()
Date:   Mon, 21 Aug 2023 00:55:17 -0700
Message-ID: <20230821075517.2320555-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b0a4fa15-df54-46df-afe7-2af03c3d56df@schaufler-ca.com>
References: <b0a4fa15-df54-46df-afe7-2af03c3d56df@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.138.205]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey, Roberto

On Thu, 2023-05-11 17:12:50 +0000, Casey Schaufler wrote:
>
> On 5/8/2023 10:02 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Enhance smack_inode_getsecurity() to retrieve the value for
> > SMACK64TRANSMUTE from the inode security blob, similarly to SMACK64.
> >
> > This helps to display accurate values in the situation where the security
> > labels come from mount options and not from xattrs.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Looks good. I have added to smack next.

Do you have any objections to backporting these patches to -stable? If not,
I'll ask it in the stable list along with another overlayfs-related fix
387ef964460f ("Smack:- Use overlay inode label in smack_inode_copy_up()").


Thanks,
Munehisa

> 
> > ---
> >  security/smack/smack_lsm.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 7a3e9ab137d..c7e37ed2799 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1463,10 +1463,19 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
> >  	struct super_block *sbp;
> >  	struct inode *ip = inode;
> >  	struct smack_known *isp;
> > +	struct inode_smack *ispp;
> > +	size_t label_len;
> > +	char *label = NULL;
> >  
> > -	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
> > +	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
> >  		isp = smk_of_inode(inode);
> > -	else {
> > +	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
> > +		ispp = smack_inode(inode);
> > +		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
> > +			label = TRANS_TRUE;
> > +		else
> > +			label = "";
> > +	} else {
> >  		/*
> >  		 * The rest of the Smack xattrs are only on sockets.
> >  		 */
> > @@ -1488,13 +1497,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
> >  			return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (!label)
> > +		label = isp->smk_known;
> > +
> > +	label_len = strlen(label);
> > +
> >  	if (alloc) {
> > -		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
> > +		*buffer = kstrdup(label, GFP_KERNEL);
> >  		if (*buffer == NULL)
> >  			return -ENOMEM;
> >  	}
> >  
> > -	return strlen(isp->smk_known);
> > +	return label_len;
> >  }
> >  
> >  
> 
