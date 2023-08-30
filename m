Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842B78D97A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjH3SdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjH3Qct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:32:49 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41027107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvMAC2d2FsaZimZF40dd+fKKbUzA1QS9AyxzoONO4GlwSxv0rFEPY6Q0y6j8Ha+TYiuKInvEZlV/0C7gb1ZFvQgvYJrTl0IA2JpG7cP+YutG6WYbqDuCnztl6PTtontKFTarT7H/VFumowf7fklKRlfSif4hdet3cm2T9+z+B1k+asd0dlTe8yMmjcRM+snG15qMNrmiiE8DbI6PTITblqEK9Q/WAAzv+0HI/Fk2rRQQjv2X8Jh/3Fdw2eAlEU47z0Mjs3iwXKTmB176YyBKsJOqSyL3S/s9O5Y3svRw/ILkS1we7bs8ImNRkw1cciVCaddF6E3m/huusOMnN0IDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scKul4w+PbfiYuggqEQ1HIw842wLaYQRLTohFHtlYpU=;
 b=cVg8jk5tuqlwrvnDAUqnqf+u+lSFnI9Omn10h/I/q9qyCQzNIx2Ttpb/eixoAfJjaVUG1y7KR5VSksN1quzAMXkANraQYDb3RcasbDeJd+MgZ40cvEumUUM9PuxmMJgZC7eHQUXN5kd8lPCHBBxkAWgbGnevGnpmvdXYSMnvQjp+6v5YnJw9DxuVqY5tnndQseM7xkqoWYmnGzK6bLdVOrz9D+15o1HX1W2rwtt06uEeu2NFRCKJshdmkhob5tRJBb64mjH4bbe4z/Z9eRdfkaWKJFLUWf7BTbjRZAAW3esQqGpwqY/sTpMdjQ7QT9AbtqeKKvNRhrk/DJdIwpNAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scKul4w+PbfiYuggqEQ1HIw842wLaYQRLTohFHtlYpU=;
 b=T88zqgUbJHIgqHarJfRI8xvbNrBF14FpXH4zu9yk6I6lkXWxaTs+ost8VUo3QNGkIhkn/B1ymRdog+56ElwfpKfxNcC3BDAJa2q6a4fDc2VS3yJMuBcJTEUHMJD3+n6MHMs92ZlOei8iRllU2HTXLPMSk6x+T1F3hMYjKL/tfAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9671.eurprd04.prod.outlook.com (2603:10a6:10:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 16:32:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 16:32:43 +0000
Date:   Wed, 30 Aug 2023 12:32:28 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i3c: master: fixes i3c bus driver probe failure
 if no i3c device attached
Message-ID: <ZO9vHAZT7M8hNueW@lizhi-Precision-Tower-5810>
References: <20230830141727.3794152-1-Frank.Li@nxp.com>
 <20230830175355.4bc2b8d2@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830175355.4bc2b8d2@xps-13>
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a754049-c26d-4080-28a8-08dba976bc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZghTQ6Jhk9TZLeGVrDHNlOycymzy0JzxWWA7PAq/DrqOECpgnx9+AzjbLKGD2uWhtBBaaeyz4pWV8fZBTNBuHq6x6GtT1oZ+/x/Ljpz0n15NKXdswMz0bxA5C0NRQ73M4bG3HeRu/Myb99kkzSbuprePSuK4Hhk0j42D/zbqlvdX8RrzuPc8Q9Re5cBAcYLU05cYptFLlgI3H2RSNYSBtRnFp8J3E8i/dkP4cqisZ3BhwdOR/QoSiGGDdukc2gBhNtkUt2CFlwCufL5TdYghVhQls8nfrYj3NuCQe2T0941MNxA+rw8vW0PZlnKg4Wbp06eLh6hoB9S2r6v0t6niA2z68h7uzIrbaCzKsQmdZss96dofSVFMedFz0jOIshrKireUp4tv2R1OYnenVwOSa1jWUqmsyDz+z+cKxMEKkJ6WqYJptVY1jNqmtLLl8gX+1T4dq4w9/mGae6Wq/+X7tU+hvsugqXPfD3VNnhUMY6hgsskxlQ7emBh9lHoTXRfmuUDbllQVLJt8ZdRib+3eFG6y+zUuY7reIgOqRif3xldvzkqzoK37fIYR+Dc8caSiFiFSmrFruu+2kbJZstknG8YfQV2qrBQDRHuo4ZAzqK1vwYdLzMzub81IQ+Vqa9PLp4C1jqDyJ6tKHHlkMVQU3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(66556008)(66476007)(6916009)(2906002)(66946007)(316002)(41300700001)(9686003)(6512007)(52116002)(66574015)(6666004)(6506007)(5660300002)(6486002)(26005)(83380400001)(86362001)(38100700002)(38350700002)(8676002)(4326008)(33716001)(8936002)(478600001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?u/9w4BDhHMIOdqyi0crTUUzHiQj8fOBEsgLimcfU0n7PDbfPpg2A8Vy43/?=
 =?iso-8859-1?Q?2fns/38rjkr4fwZmOwAGlTR8zcD3ozrTB1dVFa43EjLQ67ED6MZjmsqGEj?=
 =?iso-8859-1?Q?rMoHjtAJluZ5T+c0LJGfWIsQziLt0HnYzwYir3vpeQhgZ7Ky7NO48RBfAk?=
 =?iso-8859-1?Q?pqm5eXKblurI+Y/ZfEL2lUB/ooM9+3dqYTzTKBDqEY1/X90Oup9SQ9mbb5?=
 =?iso-8859-1?Q?3uvSyIogSxu443LoM+zOmbAGe9sg0JhgD+q0g6pF/tDtbXoCoGPvJLFOaf?=
 =?iso-8859-1?Q?zd/Sp/thG003+HGUOXET+Wnbk+5IrTyiO/4eGyELLJ70GvBJJxSm7M78xI?=
 =?iso-8859-1?Q?nWAY1sMU6WMkmW9f/qEOqrVeX0QJcqj7pKM/Ll+YGJaFkKNVk4m8jb8aCq?=
 =?iso-8859-1?Q?op05EcUK3eNnwd/qHUgUgpQPCt8t/iDjGzlAWtOqbOOC6osyrecCLa2f5N?=
 =?iso-8859-1?Q?R57w34lNYRhyiZ0TPbj7jJ+pgllswzqW3khW8d6RFeHWbQUFvWp9mpGjea?=
 =?iso-8859-1?Q?SuzKfMEpfndjhBEqcdxEoED/5aEnNbIdsXIl1U2h1LbCNJcoHbwwP3dJxr?=
 =?iso-8859-1?Q?UbRUIMkGngj7EMxalK0iIJVcVCJrmx1841g0oV88RYq315tUjLyZmOzaXN?=
 =?iso-8859-1?Q?Gmq/96lJTMgtANHEIZ9dufUfXD3z418BeV0xwJMYD24IFX6HCBIiEzm1CY?=
 =?iso-8859-1?Q?iGvYzVzZNVRg8p7Mmu7TPovTGPtFaV16vqYVLzUHOqg0U4rL3rjKvCG8G1?=
 =?iso-8859-1?Q?nMaIi0qazG6Gkb+WWP1s1Ij8Of5d1PdXa/3u2nVcZ7rg2AGUsPkRDIMu53?=
 =?iso-8859-1?Q?GX4R/q8UPRoKnI+79IbMmvhg+ZIQmCJHFN5KvdMF0f+tEsGZqF/Pz1d+YW?=
 =?iso-8859-1?Q?KlQtdaV6a4icFu9mSUsiBt0cMzb9hA3aII3AW9loGy4LMC4s9uZp/1fvAi?=
 =?iso-8859-1?Q?CfHjhwdDxYPBExJPvPQgzdHv+5jeXMrlWfqEjCbXN5GjN6o6zsvPvBVkyG?=
 =?iso-8859-1?Q?V3mIiFjA80N04XTr3TgIRvNWahZyTVQhM0CHbVzx1WY+irLo+JOSAeyLTJ?=
 =?iso-8859-1?Q?bAH6S64Gu7fzd2+33tRkNbb8PhjfpNe5n22Hg2ccenBjjE/LmZIusDlOVZ?=
 =?iso-8859-1?Q?18lQkvNkcL3G6TTB04vcRJgQzYO8f3VbzmVVa2pNQjbkeo8G1uo9+/HrOQ?=
 =?iso-8859-1?Q?eWhhicIsysTfug+Xl21PT/S50CPuH5/p+FHblOBga/zGwEzdLac0xARamI?=
 =?iso-8859-1?Q?VR+fSyiWhD2eSXev9bSoAeIguyDoEBU1yvXy26XGlj4PB7VHOrE8+uTP3q?=
 =?iso-8859-1?Q?Wi5K2IfVDGhT9dLTE6R8sezUEvoA4XUIO7uh772xOpcVVleO8qvpijLR3V?=
 =?iso-8859-1?Q?dfl/GCPQqBhBa8COM+9nbW/YhmV+Y4ZFDnf03GdW0Zg59UAA6TLpCbpIG9?=
 =?iso-8859-1?Q?/O4juaRV/0Jbn1Obdl5WS8jOeuFij+by0xc+JF8mAKj1DbxBgxhFuz9jxT?=
 =?iso-8859-1?Q?Yiu0mPHeeNBzz9obEaBWxXezXDXAEOzJb3XvxKF0sbJtCp6eObM7Z1FfEG?=
 =?iso-8859-1?Q?DpXAYiQf7QIuIACXPB0J3RYVwvSFrYjxMTUthDVxTTNllf8Jf90Sm+/AAQ?=
 =?iso-8859-1?Q?+CldChnuVzSgej2LOXVXMw5uPJGOl5cmt4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a754049-c26d-4080-28a8-08dba976bc66
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:32:43.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qUKVXHId6NXh76RCeQa5SgBPKiITa1MB4LD3fa3GWju+L41jlYNmZ2+x9qte2xCtcVXsuQrsARR5PiO0xn8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9671
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:53:55PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Wed, 30 Aug 2023 10:17:26 -0400:
> 
> > In i3c_master_bus_init()
> > {	...
> > 	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
> > 	if (ret && ret != I3C_ERROR_M2)
> > 			  ^^^ // it is enum i3c_error_code
> > 	...
> > }
> > 
> > In dw-i3c-master.c implementation:
> > dw_i3c_ccc_set()
> > {	...
> > 	ret = xfer->ret;
> > 	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
> > 		ccc->err = I3C_ERROR_M2;
> > 
> > 	dw_i3c_master_free_xfer(xfer);
> > 
> > 	return ret;
> > }
> > 
> > Return enum i3c_error_code when error happen in i3c_master_rstdaa_locked().
> 
> I am sorry but the commit log needs to be worked on.
> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2:
> >     - cc stable
> > 
> >  drivers/i3c/master.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 08aeb69a78003..00a82f3ab9ac0 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -783,6 +783,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
> >  	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> >  	i3c_ccc_cmd_dest_cleanup(&dest);
> >  
> > +	if (ret)
> > +		ret = cmd.err;
> 
> Shouldn't this happen in i3c_master_send_ccc_cmd_locked()?

Sorry, This patch is not necesary at all.
i3c_master_send_ccc_cmd_locked() already handled it.
Only need second patch. You can discard this patch.

Do you need me send 2nd patch only? Or you can just pick 2nd one?

> 
> > +
> >  	return ret;
> >  }
> >  
> 
> 
> Thanks,
> Miquèl
