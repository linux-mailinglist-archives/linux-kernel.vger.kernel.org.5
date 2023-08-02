Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84C76DB10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHBW7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHBW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:58:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E402D49;
        Wed,  2 Aug 2023 15:58:54 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MhsTg014348;
        Wed, 2 Aug 2023 22:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cY/wIaQSOUCxsMhJPZ2azJSYyXPcSl4C3s+8L6+HmKU=;
 b=STbb3hwuuEBuse6+e9tX2uFRf+z9zAivP6mxfvD0FkkYSp/EBALFAKWVHewu8trfDJPE
 Oy4Mirbcp0fo0bWspncg97SAi0HvK590fB/4srx3hLLjgV9nvgIRZP/xUqmlAVbrEtyd
 f9fT0lno3u66GbrRoX0NjaYUFPM3PPd9IHhd6u6UPrUxnSjFdh5RcP8DeQFX2gzqKj2j
 aYjVNGZubS6EIPnmbFI841oSmiheGb59i0CgzbRHwzHfHZKWQKHnyuwBz9R2qO4uscYN
 oirYNnT1T+xP9mDoCn7myJF9ZTjMc3jfSXpXqdeNM1ZR6LIX9XY8XWOPk5QvF+tZ4GP7 Kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s806q08gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:58:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372Kv75S018951;
        Wed, 2 Aug 2023 22:58:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5ekkrckx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:58:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 372MwiZG63177042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 22:58:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB77F58053;
        Wed,  2 Aug 2023 22:58:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D36B58043;
        Wed,  2 Aug 2023 22:58:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.115.23])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Aug 2023 22:58:43 +0000 (GMT)
Message-ID: <7546796cdbe19e886e9df5a7d1212b2bd41cd838.camel@linux.ibm.com>
Subject: Re: [PATCH 1/6] integrity: PowerVM support for loading CA keys on
 machine keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 18:58:43 -0400
In-Reply-To: <20230714153435.28155-2-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
         <20230714153435.28155-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GwiSCzNYZe8EoyS3N7_jL9sDzwtf9lBp
X-Proofpoint-ORIG-GUID: GwiSCzNYZe8EoyS3N7_jL9sDzwtf9lBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020199
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 11:34 -0400, Nayna Jain wrote:
> Keys that derive their trust from an entity such as a security officer,
> administrator, system owner, or machine owner are said to have "imputed
> trust". CA keys with imputed trust can be loaded onto the machine keyring.
> The mechanism for loading these keys onto the machine keyring is platform
> dependent.
> 
> Load keys stored in the variable trustedcadb onto the .machine keyring
> on PowerVM platform.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>

